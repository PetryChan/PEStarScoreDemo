# PEStarScoreDemo
iOS星级评分控件
![2019-07-19 19.07.31.gif](https://upload-images.jianshu.io/upload_images/1520914-3a78bb80901699f5.gif?imageMogr2/auto-orient/strip)

***
###支持点击和滑动
原理简介:
一.使用了UIControl控件,点击和滑动事件的监听不用自己搞,自带buff.页面设置五颗星星,就给UIControl添加5个Button.每个button的tag从0开始...

![Snip20190719_17.png](https://upload-images.jianshu.io/upload_images/1520914-e55021edd37cbaaa.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

二.在以上点击或者拖动相应的回调事件中书写我们的业务逻辑.

     比如我们点击到3.4颗星星的进度,我们的代码执行了以下三件事:
     1.得到当前进度的点坐标,遍历五个button,找到当前点所在的button,就是tag=2的button.获取当前点的数值count.   
          count = button.tag+(当前点的x坐标-button.x)/button.width. 从而得到count = 2.4
     2.遍历所有button,设置其图片为灰色星星的图片
     3.遍历<=count的button 设置其图标为黄色星星的图片
     4.对当前button的图片单独处理,count取小数0.4,利用图片截取方法截取黄色星星宽度*0.4的图片,然后将其在灰色星星图片上进行合成,
          这样就能得到一张坐标40%的是黄色星星,右边60%是灰色星星的图片.然后返回给当前button,至此大工告成.
