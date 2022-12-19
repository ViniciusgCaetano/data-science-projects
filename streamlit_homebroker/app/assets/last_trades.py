import plotly.graph_objects as go
from plotly.subplots import make_subplots
import pandas as pd

def last_trades(trades_df):


    trade_price = trades_df["price"]
    trade_amount = trades_df["qty"]
    trade_time = trades_df['time']

    table = go.Table(
            header=dict(
                values=['<b>Price</b>', '<b>Amount</b>', '<b>Time</b>'],
                line_color='gray', fill_color='gray',
                align='center',font=dict(color='black', size=15)
                ),
            cells=dict(
                values=[trade_price, trade_amount, trade_time],
                line_color='gray',
                fill_color='gray',
                height=25,
                align=['left', 'right', 'right'],
                font=dict(color=[['green' if x == True else 'red' for x in trades_df['isBuyerMaker']], 'white', 'lightgray'],
                        size=14)
                )
        )
    
    fig = make_subplots(
        rows=1, cols=1,
        specs=[[{"type": "table"}]],
        vertical_spacing=0
  
        )
    
    fig.add_trace(table, row=1, col=1)
    fig['layout'].update(margin=dict(l=0,r=0,b=0,t=0))
    fig['layout'].update(height=850)
    
    return fig