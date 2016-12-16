#ifndef CACHE_SET_HAWKEYE_H
#define CACHE_SET_HAWKEYE_H

#include "cache_set.h"

class CacheSetHAWKEYE : public CacheSet
{
   public:
      CacheSetHAWKEYE(CacheBase::cache_t cache_type,
            UInt32 associativity, UInt32 blocksize);
      ~CacheSetHAWKEYE();

      UInt32 getReplacementIndex(CacheCntlr *cntlr);
      void updateReplacementIndex(UInt32 accessed_index);
      void updateReplacementEIP(UInt32 accessed_index, IntPtr eip);
      void incrementAge(UInt32 index);
   private:
      UInt8* m_occupancy;
      int* m_last_occurrence;
      UInt8* m_priority_eviction;
      UInt8 last_index;
      IntPtr* m_eip_list;
      IntPtr* m_last_eip_accessing;
      int* m_eip_score;
};

#endif /* CACHE_SET_HAWKEYE_H */
