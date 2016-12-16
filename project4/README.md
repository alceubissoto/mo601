1 - Os arquivos do sniper que foram criados (cache_set_hawkeye.cc, cache_set_hawkeye.d, cache_set_hawkeye.h) devem ser colocados em: "sniper-6.1/common/core/memory_subsystem/cache".
2 - Os seguintes arquivos foram modificados apenas para que o sniper reconheça a nova replacement policy criada: cache_set.cc, cache_base.h. Estes também devem ser posicionados no diretório  "sniper-6.1/common/core/memory_subsystem/cache".
3 - O restante dos arquivos foram modificados para ter acesso ao PC. Basta posicionar a pasta dentro do diretorio do sniper.
4 - O script usado para a geração dos resultados é o go_sniper.sh. Devido a um problema com um loop "for", que executava o dobro de vezes que deveria, não foi possível deixá-lo bem escrito, sem repetições, etc.

