import streamlit as st
import streamlit_nested_layout
import numpy as np
import api_connections.get_candle_data as gcd
import api_connections.get_order_data as gmd
import api_connections.get_last_trades as glt
import api_connections.get_metrics_of_pair as gmp
import assets.order_graph as aog
import assets.candle_graph as acg
import assets.last_trades as alt



st.set_page_config(layout="wide")

with st.empty():
    while True:
        metrics = gmp.get_market_metrics('BTCUSDT')
            # col1_1, col2_1, col3_1, col4_1, col5_1, col6_1, col7_1 = st.columns(7)
            # metrics = gmp.get_market_metrics('BTCUSDT')
            # with col1_1:
            #     st.title('BTC/USDT')
            # with col2_1:
            #     st.metric('Price', "{:.2f}".format(float(metrics['lastPrice'])))
            # with col2_1:
            #     st.metric('24h Change', "{:.2f}".format(float(metrics['priceChange'])))
            # with col4_1:
            #     st.metric('24h High', "{:.2f}".format(float(metrics['highPrice'])))
            # with col5_1:
            #     st.metric('24h Low', "{:.2f}".format(float(metrics['lowPrice'])))
            # with col6_1:
            #     st.metric('24h Volume(BTC)',  "{:.2f}".format(float(metrics['volume'])))
            # with col7_1:
            #     col7_1.metric('24h Volume(USDT)', "{:.2f}".format(float(metrics['quoteVolume']))) 
        
        col1, col2, col3 = st.columns([1, 3, 1])
        with col1:
            col1_1, col1_2 = st.columns(2)
            with col1_1:
                st.title('BTC/USDT')
           
            order_json = gmd.get_orders('BTCUSDT', 15)
            st.write(order_json)
            fig = aog.order_book(order_json)
            config=dict(
                            displayModeBar=False, 
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
            


            df = gcd.get_candles('BTCUSDT', '1d')
            fig = acg.candle_graph(df)
            config=dict(
                            displayModeBar=False,
                            
                        )
            
            st.plotly_chart(fig, use_container_width=True, config=config)
            

        with col3:
            col3_1, col3_2 = st.columns(2)
            with col3_1:
                st.metric('24h Volume(BTC)',  "{:.2f}".format(float(metrics['volume'])))
            with col3_2:
                col3_2.metric('24h Volume(USDT)', "{:.2f}".format(float(metrics['quoteVolume']))) 

            df = glt.get_last_trades('BTCUSDT')
            fig = alt.last_trades(df)
            st.plotly_chart(fig, use_container_width=True, config=config)

          