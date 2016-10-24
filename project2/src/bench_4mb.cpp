#include <iostream>
#include <vector>
#include <cstdlib>

int main( int argc, char *argv[] ) {
    int k;
    if(argc == 2) {
        char* pEnd;
        k = strtol(argv[1], &pEnd, 10);
    } else {
      k = 2;
    }
    int page_size = 1024*1024;
    int tlb_size = 512;
    std::vector<int> vetor(tlb_size*page_size*k);
    for (int h=0; h<1000; h++) {
        for(int i=0; i<1000; i++) {
            for (int j=0; j<tlb_size*k; j++) {
                vetor[j*page_size]++;
            }
        }
    }
}
