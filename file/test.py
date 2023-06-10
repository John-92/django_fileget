# -*- coding=utf-8 -*-
# @Time: 2023/6/10 14:20
# @Author: John
# @File: test.py
# @Software: PyCharm
import os
import time

t=os.walk('/tmp/pycharm_project_847/img/', topdown = False)
print(t)

for dirName, subdirList, fileList in t:
	# print('Folder: %s' % dirName)
	for fname in fileList:
		# print('\t%s' % fname)
		filepath=os.path.join(dirName,fname)
		fileLength=os.stat(filepath)[-4]
		fileCreateTime=os.stat(filepath)[-3]
		timestr = time.strftime('%Y-%m-%d', time.localtime(fileCreateTime))
		print(f'filepath{filepath},{fileLength},{timestr}')
		# print(f'os.stat')

a={}
a["o"]=0
a["9"]=[]

a["9"].append(1)
print(a)