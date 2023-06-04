# -*- coding=utf-8 -*-
# @Time: 2023/6/3 16:44
# @Author: John
# @File: forms.py
# @Software: PyCharm
from django import forms
class FileForm(forms.Form):
    print("jkjjj")
    fileIn=forms.CharField(label="name",widget=forms.widgets.TextInput(attrs={'class':'form-control',
                       'placeholder':"please input the filename" }))
    print("kkkk")
