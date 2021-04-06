#%%
import matplotlib.pyplot as plt; plt.rcdefaults()
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

#%%
# Pandas configuration
# Use 3 decimal places in output display
pd.set_option("display.precision", 3)
# Don't wrap repr(DataFrame) across additional lines
pd.set_option("display.expand_frame_repr", False)
# Set max rows displayed in output to 25
pd.set_option("display.max_rows", 25)

#%%
col_names = ['Name', 'Genre', 'Count']
data = pd.read_csv(r'./set1q1results.csv', names=col_names)
# df = pd.DataFrame(data)
print(df.head())
#print('How many rows the dataset: ', data['Count'].count() )
print(df.dtypes)

#%%
(data.groupby('Genre', as_index=False)
   .agg({'Name':'first',
         'Count':'sum'
         })
   .to_csv('file.csv')
)

print(data.head())

# total_by_genre = data.groupby(['Genre', 'Count']).mean()
# total_by_genre.head()

#%%
plt.bar(data['name'], data['count'], performance, align='center', alpha=0.5)
plt.xticks(y_pos, objects)
plt.ylabel('Usage')
plt.title('Programming language usage')

plt.show()


# %%
