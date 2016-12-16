#include "cache_set_hawkeye.h"
#include "log.h"
// MRU: Most Recently Used

CacheSetHAWKEYE::CacheSetHAWKEYE(
        CacheBase::cache_t cache_type,
        UInt32 associativity, UInt32 blocksize) :
    CacheSet(cache_type, associativity, blocksize)
{
  m_occupancy = new UInt8[m_associativity*8];
  m_last_occurrence = new int[m_associativity];
  m_priority_eviction = new UInt8[m_associativity];
  m_last_eip_accessing = new IntPtr[m_associativity];
  last_index = 0;
  m_eip_list = new IntPtr[50];
  m_eip_score = new int[50];
  for (UInt32 i = 0; i < m_associativity*8; i++)
    m_occupancy[i] = 0;

  for (UInt32 i = 0; i < m_associativity; i++) {
    m_last_occurrence[i] = -1;
    m_priority_eviction[i] = 15;
    m_last_eip_accessing[i] = 0;
  }
  for (UInt32 i = 0; i < 50; i++) {
    m_eip_list[i] = 0;
    m_eip_score[i] = 4;
  }
}

CacheSetHAWKEYE::~CacheSetHAWKEYE()
{
    delete [] m_occupancy;
}

UInt32
CacheSetHAWKEYE::getReplacementIndex(CacheCntlr *cntlr)
{
  //IntPtr eip;
  // Invalidations may mess up the LRU bits
  //LOG_PRINT("Entering getReplacementIndex\n");
  //LOG_PRINT("m_occupancy before: \n");
  /*if(cntlr != NULL) {
    eip = cntlr->getEIP();
    printf("access %lx \n", eip);
  } else {
    printf("Cntlr null");
  }*/
  //for (UInt32 i = 0; i < m_associativity; i++)
    //LOG_PRINT("%d ", m_occupancy[i]);

  //LOG_PRINT("---------------------")


  for (UInt32 i = 0; i < m_associativity; i++)
  {
    if (!m_cache_block_info_array[i]->isValid())
    {
      //incrementAge(i);
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
        // Decrease the score of the last EIP that accessed the line
        // if evicted cache line was predicted as friendly

        if ((m_last_eip_accessing[i] != 0)) {
          for(UInt32 j = 0; j < 50; j++) {
            if (m_eip_list[j] == m_last_eip_accessing[i]) {
              if (m_eip_score[j] > 3)
                m_eip_score[j]--;
            }
          }
        }
        return i;
      }
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
{}

void
CacheSetHAWKEYE::updateReplacementEIP(UInt32 accessed_index, IntPtr eip)
{
  //LOG_PRINT("Entering updateReplacementIndex\n");
  //LOG_PRINT("accessed_index: %d", accessed_index);
  int count = 0;
  for (UInt32 i = 0; i < 50; i++) {
    if(m_eip_list[i] != eip) {
      count++;
    } else {
      break;
    }
  }
  if(count == 50) {
    for (UInt32 i = 0; i < 50; i++) {
      if(m_eip_list[i] == 0) {
        m_eip_list[i]=eip;
        count = i;
        //printf("Amount of different eip: %d \n", i+1);
        break;
      }
    }
  }

  m_last_eip_accessing[accessed_index] = eip;
  int available_interval = 0;
  int total_interval = 0;
  int last_position_appeared;
  for (UInt32 i = 0; i < m_associativity; i++) {
    if (m_last_occurrence[i]==last_index) {
      m_last_occurrence[i] = -1;
      break;
    }
  }
  m_occupancy[last_index] = 0;

  //printf("accessed_index: %d\n", accessed_index);
//CHECANDO AS POSICOES PRA VER SE NAO TEM NADA MAIOR QUE m_associativity-1
  last_position_appeared = m_last_occurrence[accessed_index];
  if(last_position_appeared > -1) {
    if (last_position_appeared > last_index) {
      for (UInt32 i = last_position_appeared; i < m_associativity*8; i++) {
        if (m_occupancy[i] < 15) {
          available_interval++;
        }
        total_interval++;
      }
      for (UInt32 i = 0; i < last_index; i++) {
        if (m_occupancy[i] < 15) {
          available_interval++;
        }
          total_interval++;
      }

    } else { //(last_position_appeared < last_index)
      for (UInt32 i = last_position_appeared; i < last_index; i++) {
        if (m_occupancy[i] < 15) {
          available_interval++;
        }
        total_interval++;
      }

    }
  }
  //printf("3");


  //Controle vetor de ocupação
  if ((available_interval == total_interval) and (available_interval>0)) { //HIT!
    m_priority_eviction[accessed_index] = 0; //test
    //Hit, train PC positivelly
    if (m_eip_score[count] < 7)
      m_eip_score[count]++;
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
    //Miss, train PC negativelly
    if (m_eip_score[count] > 0)
      m_eip_score[count]--;
      //m_priority_eviction[accessed_index] = 15; //test
      /*
    printf("MISS: %d", accessed_index);
    printf("last_index: %d\n", last_index);
    for (UInt32 i = 0; i < m_associativity*8; i++)
      printf("%d, ", m_occupancy[i]);
    printf("\nUpdate Complete\n");

    printf("m_priority_eviction\n");
    for (UInt32 i = 0; i < m_associativity; i++)
      printf("%d, ", m_priority_eviction[i]);
    printf("\n");

    printf("m_eip_score\n");
    for (UInt32 i = 0; i < 50; i++)
      printf("%d, ", m_eip_score[i]);
    printf("\nEIP Score Complete\n");
   */
  }

    //based on PC, indicate if it should be evicted.
  if (total_interval > 0) {
    if(m_eip_score[count] > 3)
      m_priority_eviction[accessed_index] = 0;
    else
      m_priority_eviction[accessed_index] = 15;
  } else {
    //printf("\n First Access \n");
    m_priority_eviction[accessed_index] = 8;
  }


  //update m_last_occurrence
  m_last_occurrence[accessed_index] = last_index;


  //printf("available: %d, total: %d\n", available_interval, total_interval);
  //printf("4");
  //LOG_PRINT("m_occupancy update: \n");
  /*printf("accessed_index: %d\n", accessed_index);
  printf("m_priority_eviction\n");
  for (UInt32 i = 0; i < m_associativity; i++)
    printf("%d, ", m_priority_eviction[i]);
  printf("\n");

  printf("m_last_occurrence\n");
  for (UInt32 i = 0; i < m_associativity; i++)
    printf("%d, ", m_last_occurrence[i]);
  printf("\n");

  printf("last_index: %d\n", last_index);
  for (UInt32 i = 0; i < m_associativity*8; i++)
    printf("%d, ", m_occupancy[i]);
  printf("\nUpdate Complete\n");

  for (UInt32 i = 0; i < 20; i++)
    printf("%d, ", m_eip_score[i]);
  printf("\nEIP Score Complete\n");
  */
  // Lista circular
  //printf("ANTERIOR last_index: %d\n", last_index);
  if (last_index < (m_associativity*8)-1)
    last_index++;
  else
    last_index=0;
  //printf("PROXIMO last_index: %d\n", last_index);
}
