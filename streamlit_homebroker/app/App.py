import streamlit as st
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
    st.text_area('Oi')

with col2:
    st.text_area('Oi 2')

with col3:
    st.text_area('Oi 3')