# Banate CAD

A set of programs for creative visualization and modeling.

BanateCAD - A 3D modeling program

HeadsUp - Primarily 2D of the same variety as the Processing environment

## Revised Version

This is a special revised version tailor-made for modeling Moon Lamp.

![Prototype](https://cdn.instructables.com/F0J/XHYT/JCUULS1R/F0JXHYTJCUULS1R.RECTANGLE1.jpg)

Please find more details at instructables:

https://www.instructables.com/id/Print-Your-Own-Moon/

## Docker Image

If you encounter difficulties on setup full stack of environment to run lua scripts. Try the docker image:

```
docker run -it -v `pwd`:/lua moononournation/debian-imagemagick-lua-meshlab:1.0.1 sh Examples/cmdLineBatchJob.sh
```
