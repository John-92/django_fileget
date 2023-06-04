
# -*- coding: UTF-8 -*-
import os,webbrowser
import time

from django.conf import settings
from django.shortcuts import render
from django.http import HttpResponse, JsonResponse
from .forms import FileForm

# Create your views here.
from django.views.decorators.csrf import csrf_protect, csrf_exempt


def index(request):
    return render(request, '1/test.html')

@csrf_exempt
def storage_view(request):
    """
    存储数据
    :param request:
    :return:
    """

    if request.method == "POST":
        img = request.FILES.get("commodityImage")
        # img = request.FILES
        print(f"img,{img}")
        url = "/img/"
        old_name = img.name
        suffix = old_name.rsplit(".")[1]#获取后缀名
        img_name = int(time.time())
        # img_name = 1685766575
        print(f'dirs{settings.TEMPLATES[0].keys()}')
        # for i in range(4):
        #     print(f'dirs{settings.TEMPLATES[0][i]}')
        dir = os.path.join(os.path.join(settings.BASE_DIR, 'img'),str(img_name)+'.'+suffix)
        # dir = os.path.join(os.path.join(settings.TEMPLATES[0]['DIRS'][0], 'img'),str(img_name)+'.'+suffix)
        print(f'dir{dir}')
        destination = open(dir,'wb+')
        for chunk in img.chunks():
            destination.write(chunk)
        destination.close()
        # models.datainfo.objects.create(
        #     data_photo = url + str(img_name)+'.'+suffix,
        #     add_time = timezone.now()
        # )
        return JsonResponse({"status":True})
    else:
        return JsonResponse({"status":False,"error":"请求错误"})


@csrf_exempt
def show_view(request):
    if request.method=="GET":
        showfile=FileForm()
        print(showfile)
        filecontent={'99aaa':"uuu","showfile":showfile}
        return render(request, '1/showfile.html', filecontent)
    else:
        print('iiiiii')
        f=request.POST
        f=FileForm(request.POST)
        # print(f.cleaned_data.keys())
        print(f'f---{f.is_valid()}')
        if f.is_valid():
            print(f'f---sss{f.clean()}')
            filename=f.cleaned_data['fileIn']
            filepath = os.path.join(os.path.join(settings.BASE_DIR, 'img'), str(filename))
            with open(filepath) as t:
                r=t.read()
                # print(t.read())
                filecontent = {'99aaa': "uuu", "showfile": r}

            print(filecontent.values())



    # return render(request, '1/showfile.html',filecontent)
        return render(request, '1/showfile.html',filecontent)
