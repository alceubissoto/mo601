#include "cache_set_hawkeye.h"
#include "log.h"
// MRU: Most Recently Used

CacheSetHAWKEYE::CacheSetHAWKEYE(
      CacheBase::cache_t cache_type,
      UInt32 associativity, UInt32 blocksize) :
   CacheSet(cache_type, associativity, blocksize)
{
   m_occupancy = new UInt8[m_associativity*8];
   m_last_occurence = new int[m_associativity];
   m_priority_eviction = new UInt8[m_associativity];
   last_index = 0;
   for (UInt32 i = 0; i < m_associativity*8; i++)
      m_occupancy[i] = 0;

   for (UInt32 i = 0; i < m_associativity; i++) {
      m_last_occurence[i] = -1;
      m_priority_eviction[i] = 7;
   }
}

CacheSetHAWKEYE::~CacheSetHAWKEYE()
{
   delete [] m_occupancy;
}

UInt32
CacheSetHAWKEYE::getReplacementIndex(CacheCntlr *cntlr)
{
   // Invalidations may mess up the LRU bits
   //LOG_PRINT("Entering getReplacementIndex\n");
   //LOG_PRINT("m_occupancy before: \n");

   //for (UInt32 i = 0; i < m_associativity; i++)
      //LOG_PRINT("%d ", m_occupancy[i]);

   //LOG_PRINT("---------------------")


   for (UInt32 i = 0; i < m_associativity; i++)
   {
      if (!m_cache_block_info_array[i]->isValid())
      {
         //updateReplacementIndex(i);
         return i;
      }
   }

   int target = m_associativity-1;
   while (target >= 0)
   {

      for (UInt32 i = 0; i < m_associativity; i++)
      {
         if (m_priority_eviction[i] == target && isValidReplacement(i))
         {
            //printf("Way 2 evicted: %d", i);
            //updateReplacementIndex(i);
            incrementAge(i);
            return i;
         }
         //printf("TARGET ++ ");
      }
      //printf("target: %d", target);
      target--;
   }

   LOG_PRINT_ERROR("Error Finding Hawkeye bits");
}

void CacheSetHAWKEYE::incrementAge(UInt32 index) {
  //Alterar o vetor de eviction (LRU)
  for (UInt32 i = 0; i < m_associativity; i++) {
    if (m_priority_eviction[i] < m_priority_eviction[index]) {
      m_priority_eviction[i]++;
    }
  }
  m_priority_eviction[index] = 0;
}

void
CacheSetHAWKEYE::updateReplacementIndex(UInt32 accessed_index)
{
   //LOG_PRINT("Entering updateReplacementIndex\n");
   //LOG_PRINT("accessed_index: %d", accessed_index);
   int available_interval = 0;
   int total_interval = 0;
   int last_position_appeared;
   //printf("1");
   for (UInt32 i = 0; i < m_associativity; i++) {
      if (m_last_occurence[i]==last_index) {
         m_last_occurence[i] = -1;
         break;
      }
   }
   m_occupancy[last_index] = 0;

   //printf("accessed_index: %d\n", accessed_index);
   //printf("2");
//CHECANDO AS POSICOES PRA VER SE NAO TEM NADA MAIOR QUE m_associativity-1
   last_position_appeared = m_last_occurence[accessed_index];
   if(last_position_appeared > -1) {
     if (last_position_appeared > last_index) {
        for (UInt32 i = last_position_appeared; i < m_associativity*8; i++) {
          if (m_occupancy[i] < 13) {
             available_interval++;
          }
          total_interval++;
        }
        for (UInt32 i = 0; i < last_index; i++) {
          if (m_occupancy[i] < 13) {
             available_interval++;
          }
          total_interval++;
        }

     } else { //(last_position_appeared < last_index)
       for (UInt32 i = last_position_appeared; i < last_index; i++) {
         if (m_occupancy[i] < 13) {
            available_interval++;
         }
         total_interval++;
       }

     }
   }
   //printf("3");
   m_last_occurence[accessed_index] = last_index;
   m_priority_eviction[accessed_index] = 0;

//INCREMENTANDO VETOR

   if ((available_interval == total_interval) and (available_interval>0)) { //HIT!
     if (last_position_appeared > last_index) {
        for (UInt32 i = last_position_appeared; i < m_associativity*8; i++) {
          m_occupancy[i]++;
        }
        for (UInt32 i = 0; i < last_index; i++) {
          m_occupancy[i]++;
        }

     } else { //(last_position_appeared < last_index)
       for (UInt32 i = last_position_appeared; i < last_index; i++) {
          m_occupancy[i]++;
       }
     }

   } else if (available_interval < total_interval) { //MISS
      m_priority_eviction[accessed_index] = 15;

      /*printf("MISS: %d", accessed_index);
      printf("last_index: %d\n", last_index);
      for (UInt32 i = 0; i < m_associativity*8; i++)
          printf("%d, ", m_occupancy[i]);
      printf("\nUpdate Complete\n");
      printf("m_priority_eviction\n");
      for (UInt32 i = 0; i < m_associativity; i++)
          printf("%d, ", m_priority_eviction[i]);
      printf("\n");
      */
   }
   //printf("available: %d, total: %d\n", available_interval, total_interval);
   //printf("4");
   //LOG_PRINT("m_occupancy update: \n");
   /*printf("accessed_index: %d\n", accessed_index);
   printf("m_priority_eviction\n");
   for (UInt32 i = 0; i < m_associativity; i++)
       printf("%d, ", m_priority_eviction[i]);
   printf("\n");

   printf("m_last_occurence\n");
   for (UInt32 i = 0; i < m_associativity; i++)
       printf("%d, ", m_last_occurence[i]);
   printf("\n");

   printf("last_index: %d\n", last_index);
   for (UInt32 i = 0; i < m_associativity*8; i++)
       printf("%d, ", m_occupancy[i]);
   printf("\nUpdate Complete\n");
  */
   // Lista circular
   //printf("ANTERIOR last_index: %d\n", last_index);
   if (last_index < (m_associativity*8)-1)
      last_index++;
   else
      last_index=0;
   //printf("PROXIMO last_index: %d\n", last_index);
}
