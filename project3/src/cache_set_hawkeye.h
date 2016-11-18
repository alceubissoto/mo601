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
      void incrementAge(UInt32 index);
   private:
      UInt8* m_occupancy;
      int* m_last_occurence;
      UInt8* m_priority_eviction;
      UInt8 last_index;
};

#endif /* CACHE_SET_HAWKEYE_H */
