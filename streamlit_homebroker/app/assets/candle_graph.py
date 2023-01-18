import plotly.graph_objects as go
from plotly._subplots import make_subplots

def candle_graph(df):

    fig = make_subplots(rows=2, cols=1, shared_xaxes=True, 
               vertical_spacing=0.05, subplot_titles=('Price Variation', 'Traded Volume'), 
               row_width=[0.1, 0.3])

    fig.add_trace(go.Candlestick(x=df["open_time"], open=df["open_price"], high=df["high_price"],
                    low=df["low_price"], close=df["close_price"], name="BTCUSDT", showlegend=False), 
                    row=1, col=1
    )


    fig.add_trace(go.Bar( x=df['open_time'], y=df['volume'], showlegend=False), row=2, col=1)

    fig.update(layout_xaxis_rangeslider_visible=False
                )
    
    fig['layout'].update(margin=dict(l=0,r=0,b=0,t=20))
    fig['layout'].update(dragmode=False)
    fig['layout'].update(yaxis=dict(side='right'))
    fig['layout'].update(height=700)
    return fig
