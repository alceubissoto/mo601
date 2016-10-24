1- Para gerar os resultados do toy benchmark, deve-se setar a variável de ambiente PIN_HOME com o diretório do pin, e rodar o script run_bench.sh.
2- Os arquivos já compilados do pin são:
      file_project2_4k='project2_4k.so'
      file_project2_4mb='project2_4mb.so'
3- Os gráficos foram feitos utilizando o plotly, e o código usado está em graph.py
4- As pintools utilizadas para cache de 4k e 4mb respectivamente são project2_4k.cpp e project2_4mb.cpp.
5 - O csv foi gerado utilizando o script generate_csv.sh. Para rodá-lo, basta executá-lo na mesma pasta que estão os arquivos de resultado.
6- As análises do spec foram rodadas utilizando a pintool já citada, adicionando as linhas: 
'''
submit        = /home/abissoto/Downloads/pinplay/pin -t /home/abissoto/Downloads/pinplay/source/tools/Memory/obj-intel64/project2_4k.so -- $command 2> spec_results
use_submit_for_speed = yes
'''
e utilizando o comando runspec.

