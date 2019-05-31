#!/bin/bash

ext_note
# 默认模板需要禁用mathspec. unicode-math和newtxmath不兼容
# https://github.com/ElegantLaTeX/ElegantBook/issues/9
getArrayVar _V mathspec "false"
_V[documentclass]="elegantnote"
_P[top-level-division]="section"