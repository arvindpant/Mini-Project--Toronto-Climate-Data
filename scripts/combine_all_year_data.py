#!/usr/bin/env python
# coding: utf-8

# In[94]:


import glob
import pandas as pd
import sys


# In[96]:


input_path = sys.argv[1]
output_path = sys.argv[2]


# In[97]:


all_csv_files = glob.glob(input_path+"/*.csv")


# In[100]:


combined_csv_data = pd.concat([pd.read_csv(f, index_col=None, header=0) for f in all_csv_files],ignore_index=True)


# In[99]:


combined_csv_data.to_csv(output_path+"/all_years.csv")


# In[ ]:




