#!/bin/bash

# use this path to set custom addOptions, PANDOCVARS and LSTSET COPYPAGE

# 启用扩展
# introduction和problemset与文档类冲突，取消writeHeader
unset _G[ext-wrap-introduction]
unset _G[ext-wrap-problemset]

# theorem 已有定义，不用扩展中的定义
_G[ext-theorem-use-tex]=false

_V[documentclass]="inkbook"
getArrayVar _V classoption "cn"