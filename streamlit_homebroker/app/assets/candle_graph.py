import plotly
import pandas as pd
import plotly.graph_objects as go
from plotly._subplots import make_subplots

def candle_graph():
    df = pd.read_csv('https://raw.githubusercontent.com/plotly/datasets/master/finance-charts-apple.csv')

    fig = make_subplots(rows=2, cols=1, shared_xaxes=True, 
               vertical_spacing=0.05, subplot_titles=('OHLC', 'Volume'), 
               row_width=[0.2, 0.7])

    # Plot OHLC on 1st row
    fig.add_trace(go.Candlestick(x=df["Date"], open=df["AAPL.Open"], high=df["AAPL.High"],
                    low=df["AAPL.Low"], close=df["AAPL.Close"], name="OHLC", showlegend=False), 
                    row=1, col=1
    )

    # Bar trace for volumes on 2nd row without legend
    fig.add_trace(go.Bar(x=df['Date'], y=df['AAPL.Volume'], showlegend=False), row=2, col=1)

    # Do not show OHLC's rangeslider plot 
    fig.update(layout_xaxis_rangeslider_visible=False
                )
    
    fig['layout'].update(margin=dict(l=0,r=0,b=0,t=0))
    fig['layout'].update(dragmode=False)

    return fig
