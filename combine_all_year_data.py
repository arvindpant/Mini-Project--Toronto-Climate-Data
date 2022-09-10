#!/usr/bin/env python
# coding: utf-8

# In[75]:


import os
import glob
import pandas as pd


# In[76]:


path = os.path.join('/Users/arvin/Data_from_F/my_docs/WeCloudData/Class1_31AUG2022/shell_scripts/Lab/')


# In[77]:


all_csv_files = glob.glob(path+"/*.csv")


# In[78]:


combined_csv_data = pd.concat([pd.read_csv(f) for f in all_csv_files],ignore_index=True)


# In[79]:


combined_csv_data.to_csv("/Users/arvin/Data_from_F/my_docs/WeCloudData/Class1_31AUG2022/shell_scripts/Lab/all_years.csv")


# In[ ]:




