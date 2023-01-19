import streamlit as st
import streamlit_nested_layout
from api_connections import get_candle_data, get_order_data, get_last_trades, get_metrics_of_pair
from assets import order_graph, candle_graph, last_trades


st.set_page_config(layout="wide")

with st.empty():
    while True:
        metrics = get_metrics_of_pair.get_market_metrics('BTCUSDT')
        col1, col2, col3 = st.columns([1, 3, 1])
        with col1:
            col1_1, col1_2 = st.columns(2)
            with col1_1:
                st.title('BTC/USDT')
           
            order_json = get_order_data.get_orders('BTCUSDT', 14)
            fig = order_graph.order_book(order_json)
            config=dict(
                            displayModeBar=False
                        )
            st.plotly_chart(fig, use_container_width=True, config=config, theme=None)


        with col2:
            
            col2_1, col2_2, col2_3, col2_4 = st.columns(4)
            with col2_1:
                st.metric('Price', "{:.2f}".format(float(metrics['lastPrice'])))
            with col2_2:
                st.metric('24h Change', "{:.2f}".format(float(metrics['priceChange'])))
            with col2_3:
                st.metric('24h High', "{:.2f}".format(float(metrics['highPrice'])))
            with col2_4:
                st.metric('24h Low', "{:.2f}".format(float(metrics['lowPrice'])))

            df = get_candle_data.get_candles('BTCUSDT', '1d')
            fig = candle_graph.candle_graph(df)
            config=dict(displayModeBar=False)
            
            st.plotly_chart(fig, use_container_width=True, config=config)
            

        with col3:
            col3_1, col3_2 = st.columns(2)
            with col3_1:
                st.metric('24h Volume(BTC)',  "{:.2f}".format(float(metrics['volume'])))
            with col3_2:
                col3_2.metric('24h Volume(USDT)', "{:.2f}".format(float(metrics['quoteVolume']))) 

            df = get_last_trades.get_last_trades('BTCUSDT')
            fig = last_trades.last_trades(df)
            st.plotly_chart(fig, use_container_width=True, config=config)

          