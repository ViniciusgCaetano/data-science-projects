import streamlit as st
import plotly.graph_objects as go
from plotly.colors import n_colors
from plotly.subplots import make_subplots
import numpy as np
import pandas as pd

st.set_page_config(layout="wide")
st.title('Home Broker project')

col1, col2, col3, col4, col5, col6, col7 = st.columns(7)
col1.title('BTC/USDT')
col2.metric('Price', 17415.93)
col3.metric('24h Change', 17415.93)
col4.metric('24h High', 17415.93)
col5.metric('24h Low', 17415.93)
col6.metric('24h Volume(BTC)', 17415.93)
col7.metric('24h Volume(USDT)', 17415.93)

col1, col2, col3 = st.columns([1, 3, 1])
with col1:
    np.random.seed(1)

    colors = n_colors('rgb(255, 200, 200)', 'rgb(200, 0, 0)', 9, colortype='rgb')
    a = np.random.randint(low=0, high=9, size=10)
    b = np.random.randint(low=0, high=9, size=10)

    fig = go.Figure(data=[go.Table(
    header=dict(
        values=['<b>Column A</b>', '<b>Column B</b>'],
        line_color='white', fill_color='white',
        align='center',font=dict(color='black', size=12)
    ),
    cells=dict(
        values=[a, b],
        line_color=[np.array(colors)[a],np.array(colors)[b]],
        fill_color=[np.array(colors)[a],np.array(colors)[b]],
        align='center', font=dict(color='white')
        ))
    ])
    fig['layout'].update(margin=dict(l=0,r=0,b=0,t=0))

    st.plotly_chart(fig, use_container_width=True)


with col2:

    df = pd.read_csv('https://raw.githubusercontent.com/plotly/datasets/master/finance-charts-apple.csv')

    fig = make_subplots(rows=2, cols=1, shared_xaxes=True, 
               vertical_spacing=0.03, subplot_titles=('OHLC', 'Volume'), 
               row_width=[0.2, 0.7])

    # Plot OHLC on 1st row
    fig.add_trace(go.Candlestick(x=df["Date"], open=df["AAPL.Open"], high=df["AAPL.High"],
                    low=df["AAPL.Low"], close=df["AAPL.Close"], name="OHLC", showlegend=False), 
                    row=1, col=1
    )

    # Bar trace for volumes on 2nd row without legend
    fig.add_trace(go.Bar(x=df['Date'], y=df['AAPL.Volume'], showlegend=False), row=2, col=1)

    # Do not show OHLC's rangeslider plot 
    fig.update(layout_xaxis_rangeslider_visible=False)

    fig['layout'].update(margin=dict(l=0,r=0,b=0,t=0))
    st.plotly_chart(fig, use_container_width=True)
    

with col3:
    np.random.seed(1)

    colors = n_colors('rgb(255, 200, 200)', 'rgb(200, 0, 0)', 9, colortype='rgb')
    a = np.random.randint(low=0, high=9, size=10)
    b = np.random.randint(low=0, high=9, size=10)

    fig = go.Figure(data=[go.Table(
    header=dict(
        values=['<b>Column A</b>', '<b>Column B</b>'],
        line_color='white', fill_color='white',
        align='center',font=dict(color='black', size=12)
    ),
    cells=dict(
        values=[a, b],
        line_color=[np.array(colors)[a],np.array(colors)[b]],
        fill_color=[np.array(colors)[a],np.array(colors)[b]],
        align='center', font=dict(color='white')
        ))
    ])
    fig['layout'].update(margin=dict(l=0,r=0,b=0,t=0))

    st.plotly_chart(fig, use_container_width=True)

