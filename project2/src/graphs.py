
# coding: utf-8

# In[1]:

import numpy as np
import plotly.plotly as py
import plotly.graph_objs as go

x = np.loadtxt('/home/abissoto/Documents/project3/results/results.csv', delimiter=',', skiprows=1, usecols=(1,2,3,4,5))
t = np.loadtxt('/home/abissoto/Documents/project3/toyresults/results.csv', delimiter=',', skiprows=1, usecols=(1,2,3,4,5))

trace1 = go.Bar(
    x=['429.mcf_4k', '429.mcf_4mb'],
    y=[x[0,0], x[3,0]],
    name='Instruction TLB Miss'
)
trace2 = go.Bar(
    x=['429.mcf_4k', '429.mcf_4mb'],
    y=[x[0,1], x[3,1]],
    name='Instruction Page Table access'
)
trace3 = go.Bar(
    x=['429.mcf_4k', '429.mcf_4mb'],
    y=[x[0,2], x[3,2]],
    name='Data TLB Miss'
)
trace4 = go.Bar(
    x=['429.mcf_4k', '429.mcf_4mb'],
    y=[x[0,3], x[3,3]],
    name='Data Page Table Access'
)
trace5 = go.Bar(
    x=['429.mcf_4k', '429.mcf_4mb'],
    y=[x[0,4], x[3,4]],
    name='Total Memory Access'
)
data = [trace1, trace2, trace3, trace4, trace5]
layout = go.Layout(
    barmode='group'
)

fig = go.Figure(data=data, layout=layout)
py.iplot(fig, filename='bar-429')


# In[2]:

trace1 = go.Bar(
    x=['456.hmmer_4k', '456.hmmer_4mb'],
    y=[x[1,0], x[4,0]],
    name='Instruction TLB Miss'
)
trace2 = go.Bar(
    x=['456.hmmer_4k', '456.hmmer_4mb'],
    y=[x[1,1], x[4,1]],
    name='Instruction Page Table access'
)
trace3 = go.Bar(
    x=['456.hmmer_4k', '456.hmmer_4mb'],
    y=[x[1,2], x[4,2]],
    name='Data TLB Miss'
)
trace4 = go.Bar(
    x=['456.hmmer_4k', '456.hmmer_4mb'],
    y=[x[1,3], x[4,3]],
    name='Data Page Table Access'
)
trace5 = go.Bar(
    x=['456.hmmer_4k', '456.hmmer_4mb'],
    y=[x[1,4], x[4,4]],
    name='Total Memory Access'
)
data = [trace1, trace2, trace3, trace4, trace5]
layout = go.Layout(
    barmode='group'
)

fig = go.Figure(data=data, layout=layout)
py.iplot(fig, filename='bar-456')


# In[3]:

trace1 = go.Bar(
    x=['471.omnetpp_4k', '471.omnetpp_4mb'],
    y=[x[2,0], x[5,0]],
    name='Instruction TLB Miss'
)
trace2 = go.Bar(
    x=['471.omnetpp_4k', '471.omnetpp_4mb'],
    y=[x[2,1], x[5,1]],
    name='Instruction Page Table access'
)
trace3 = go.Bar(
    x=['471.omnetpp_4k', '471.omnetpp_4mb'],
    y=[x[2,2], x[5,2]],
    name='Data TLB Miss'
)
trace4 = go.Bar(
    x=['471.omnetpp_4k', '471.omnetpp_4mb'],
    y=[x[2,3], x[5,3]],
    name='Data Page Table Access'
)
trace5 = go.Bar(
    x=['471.omnetpp_4k', '471.omnetpp_4mb'],
    y=[x[2,4], x[5,4]],
    name='Total Memory Access'
)
data = [trace1, trace2, trace3, trace4, trace5]
layout = go.Layout(
    barmode='group'
)

fig = go.Figure(data=data, layout=layout)
py.iplot(fig, filename='bar-471')


# In[4]:

trace1 = go.Bar(
    x=['4kb_bench_2', '4mb_bench_2','4kb_bench_6', '4mb_bench_6','4kb_bench_10', '4mb_bench_10','4kb_bench_15', '4mb_bench_15',
      '4kb_bench_19', '4mb_bench_19'],
    y=[t[10,0], t[28,0], t[14,0], t[32,0], t[0,0], t[18,0], t[5,0], t[23,0], t[9,0], t[27,0]],
    name='Instruction TLB Miss'
)
trace2 = go.Bar(
    x=['4kb_bench_2', '4mb_bench_2','4kb_bench_6', '4mb_bench_6','4kb_bench_10', '4mb_bench_10','4kb_bench_15', '4mb_bench_15',
      '4kb_bench_19', '4mb_bench_19'],
    y=[t[10,1], t[28,1], t[14,1], t[32,1], t[0,1], t[18,1], t[5,1], t[23,1], t[9,1], t[27,1]],
    name='Instruction Page Table access'
)
trace3 = go.Bar(
    x=['4kb_bench_2', '4mb_bench_2','4kb_bench_6', '4mb_bench_6','4kb_bench_10', '4mb_bench_10','4kb_bench_15', '4mb_bench_15',
      '4kb_bench_19', '4mb_bench_19'],
    y=[t[10,2], t[28,2], t[14,2], t[32,2], t[0,2], t[18,2], t[5,2], t[23,2], t[9,2], t[27,2]],
    name='Data TLB Miss'
)
trace4 = go.Bar(
    x=['4kb_bench_2', '4mb_bench_2','4kb_bench_6', '4mb_bench_6','4kb_bench_10', '4mb_bench_10','4kb_bench_15', '4mb_bench_15',
      '4kb_bench_19', '4mb_bench_19'],
    y=[t[10,3], t[28,3], t[14,3], t[32,3], t[0,3], t[18,3], t[5,3], t[23,3], t[9,3], t[27,3]],
    name='Data Page Table Access'
)
trace5 = go.Bar(
    x=['4kb_bench_2', '4mb_bench_2','4kb_bench_6', '4mb_bench_6','4kb_bench_10', '4mb_bench_10','4kb_bench_15', '4mb_bench_15',
      '4kb_bench_19', '4mb_bench_19'],
    y=[t[10,4], t[28,4], t[14,4], t[32,4], t[0,4], t[18,4], t[5,4], t[23,4], t[9,4], t[27,4]],
    name='Total Memory Access'
)
data = [trace1, trace2, trace3, trace4, trace5]
layout = go.Layout(
    barmode='group'
)

fig = go.Figure(data=data, layout=layout)
py.iplot(fig, filename='bar-bench')


# In[6]:

trace1 = go.Bar(
    x=['4kb_bench_bigger', '4mb_bench_bigger'],
    y=[t[36,0], t[37,0]],
    name='Instruction TLB Miss'
)
trace2 = go.Bar(
    x=['4kb_bench_bigger', '4mb_bench_bigger'],
    y=[t[36,1], t[37,1]],
    name='Instruction Page Table access'
)
trace3 = go.Bar(
    x=['4kb_bench_bigger', '4mb_bench_bigger'],
    y=[t[36,2], t[37,2]],
    name='Data TLB Miss'
)
trace4 = go.Bar(
    x=['4kb_bench_bigger', '4mb_bench_bigger'],
    y=[t[36,3], t[37,3]],
    name='Data Page Table Access'
)
trace5 = go.Bar(
    x=['4kb_bench_bigger', '4mb_bench_bigger'],
    y=[t[36,4], t[37,4]],
    name='Total Memory Access'
)
data = [trace1, trace2, trace3, trace4, trace5]
layout = go.Layout(
    barmode='group'
)

fig = go.Figure(data=data, layout=layout)
py.iplot(fig, filename='bar-bench-big-page')

