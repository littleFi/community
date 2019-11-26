<!--**
 * author: Di (微信小程序开发工程师)
 * organization: WeAppDev(微信小程序开发论坛)(http://weappdev.com)
 *               垂直微信小程序开发交流社区
 * 
 * github地址: https://github.com/icindy/wxParse
 * 
 * for: 微信小程序富文本解析
 * mine : http://weappdev.com/t/wxparse-alpha0-1-html-markdown/184
 */-->

<!--基础元素-->
<template name="wxParseVideo">
  <!--增加video标签支持，并循环添加-->
  <view class="{{item.classStr}} wxParse-{{item.tag}}" style="{{item.styleStr}}">
    <video class="{{item.classStr}} wxParse-{{item.tag}}-video" src="{{item.attr.src}}"></video>
  </view>
</template>

<template name="wxParseImg">
  <image class="{{item.classStr}} wxParse-{{item.tag}}" data-from="{{item.from}}" data-src="{{item.attr.src}}" data-idx="{{item.imgIndex}}" src="{{item.attr.src}}" mode="aspectFit" bindload="wxParseImgLoad" bindtap="wxParseImgTap" mode="widthFix" style="width:{{item.width}}px;"
  />
</template>

<template name="WxEmojiView">
  <view class="WxEmojiView wxParse-inline" style="{{item.styleStr}}">
    <block qq:for="{{item.textArray}}" qq:key="">
      <block class="{{item.text == '\\n' ? 'wxParse-hide':''}}" qq:if="{{item.node == 'text'}}">{{item.text}}</block>
      <block qq:elif="{{item.node == 'element'}}">
        <image class="wxEmoji" src="{{item.baseSrc}}{{item.text}}" />
      </block>
    </block>
  </view>
</template>

<template name="WxParseBr">
  <text>\n</text>
</template>
<!--入口模版-->

<template name="wxParse">
  <block qq:for="{{wxParseData}}" qq:key="">
    <template is="wxParse0" data="{{item}}" />
  </block>
</template>


<!--循环模版-->
<template name="wxParse0">
  <!--<template is="wxParse1" data="{{item}}" />-->
  <!--判断是否是标签节点-->
  <block qq:if="{{item.node == 'element'}}">
    <block qq:if="{{item.tag == 'button'}}">
      <button type="default" size="mini">
        <block qq:for="{{item.nodes}}" qq:for-item="item" qq:key="">
          <template is="wxParse1" data="{{item}}" />
        </block>
      </button>
    </block>
    <!--li类型-->
    <block qq:elif="{{item.tag == 'li'}}">
      <view class="{{item.classStr}} wxParse-li" style="{{item.styleStr}}">
        <view class="{{item.classStr}} wxParse-li-inner">
          <view class="{{item.classStr}} wxParse-li-text">
            <view class="{{item.classStr}} wxParse-li-circle"></view>
          </view>
          <view class="{{item.classStr}} wxParse-li-text">
            <block qq:for="{{item.nodes}}" qq:for-item="item" qq:key="">
              <template is="wxParse1" data="{{item}}" />
            </block>
          </view>
        </view>
      </view>
    </block>

    <!--video类型-->
    <block qq:elif="{{item.tag == 'video'}}">
      <template is="wxParseVideo" data="{{item}}" />
    </block>

    <!--img类型-->
    <block qq:elif="{{item.tag == 'img'}}">
      <template is="wxParseImg" data="{{item}}" />
    </block>

    <!--a类型-->
    <block qq:elif="{{item.tag == 'a'}}">
      <view bindtap="wxParseTagATap" class="wxParse-inline {{item.classStr}} wxParse-{{item.tag}}" data-src="{{item.attr.href}}" style="{{item.styleStr}}">
        <block qq:for="{{item.nodes}}" qq:for-item="item" qq:key="">
          <template is="wxParse1" data="{{item}}" />
        </block>
      </view>
    </block>
    <block qq:elif="{{item.tag == 'table'}}">
      <view class="{{item.classStr}} wxParse-{{item.tag}}" style="{{item.styleStr}}">
        <block qq:for="{{item.nodes}}" qq:for-item="item" qq:key="">
          <template is="wxParse1" data="{{item}}" />
        </block>
      </view>
    </block>

    <block qq:elif="{{item.tag == 'br'}}">
      <template is="WxParseBr"></template>
    </block>
    <!--其他块级标签-->
    <block qq:elif="{{item.tagType == 'block'}}">
      <view class="{{item.classStr}} wxParse-{{item.tag}}" style="{{item.styleStr}}">
        <block qq:for="{{item.nodes}}" qq:for-item="item" qq:key="">
          <template is="wxParse1" data="{{item}}" />
        </block>
      </view>
    </block>

    <!--内联标签-->
    <view qq:else class="{{item.classStr}} wxParse-{{item.tag}} wxParse-{{item.tagType}}" style="{{item.styleStr}}">
      <block qq:for="{{item.nodes}}" qq:for-item="item" qq:key="">
        <template is="wxParse1" data="{{item}}" />
      </block>
    </view>

  </block>

  <!--判断是否是文本节点-->
  <block qq:elif="{{item.node == 'text'}}">
    <!--如果是，直接进行-->
    <template is="WxEmojiView" data="{{item}}" />
  </block>

</template>



<!--循环模版-->
<template name="wxParse1">
  <!--<template is="wxParse2" data="{{item}}" />-->
  <!--判断是否是标签节点-->
  <block qq:if="{{item.node == 'element'}}">
    <block qq:if="{{item.tag == 'button'}}">
      <button type="default" size="mini">
        <block qq:for="{{item.nodes}}" qq:for-item="item" qq:key="">
          <template is="wxParse2" data="{{item}}" />
        </block>
      </button>
    </block>
    <!--li类型-->
    <block qq:elif="{{item.tag == 'li'}}">
      <view class="{{item.classStr}} wxParse-li" style="{{item.styleStr}}">
        <view class="{{item.classStr}} wxParse-li-inner">
          <view class="{{item.classStr}} wxParse-li-text">
            <view class="{{item.classStr}} wxParse-li-circle"></view>
          </view>
          <view class="{{item.classStr}} wxParse-li-text">
            <block qq:for="{{item.nodes}}" qq:for-item="item" qq:key="">
              <template is="wxParse2" data="{{item}}" />
            </block>
          </view>
        </view>
      </view>
    </block>

    <!--video类型-->
    <block qq:elif="{{item.tag == 'video'}}">
      <template is="wxParseVideo" data="{{item}}" />
    </block>

    <!--img类型-->
    <block qq:elif="{{item.tag == 'img'}}">
      <template is="wxParseImg" data="{{item}}" />
    </block>

    <!--a类型-->
    <block qq:elif="{{item.tag == 'a'}}">
      <view bindtap="wxParseTagATap" class="wxParse-inline {{item.classStr}} wxParse-{{item.tag}}" data-src="{{item.attr.href}}" style="{{item.styleStr}}">
        <block qq:for="{{item.nodes}}" qq:for-item="item" qq:key="">
          <template is="wxParse2" data="{{item}}" />
        </block>
      </view>
    </block>

    <block qq:elif="{{item.tag == 'br'}}">
      <template is="WxParseBr"></template>
    </block>
    <!--其他块级标签-->
    <block qq:elif="{{item.tagType == 'block'}}">
      <view class="{{item.classStr}} wxParse-{{item.tag}}" style="{{item.styleStr}}">
        <block qq:for="{{item.nodes}}" qq:for-item="item" qq:key="">
          <template is="wxParse2" data="{{item}}" />
        </block>
      </view>
    </block>

    <!--内联标签-->
    <view qq:else class="{{item.classStr}} wxParse-{{item.tag}} wxParse-{{item.tagType}}" style="{{item.styleStr}}">
      <block qq:for="{{item.nodes}}" qq:for-item="item" qq:key="">
        <template is="wxParse2" data="{{item}}" />
      </block>
    </view>

  </block>

  <!--判断是否是文本节点-->
  <block qq:elif="{{item.node == 'text'}}">
    <!--如果是，直接进行-->
    <template is="WxEmojiView" data="{{item}}" />
  </block>

</template>


<!--循环模版-->
<template name="wxParse2">
  <!--<template is="wxParse3" data="{{item}}" />-->
  <!--判断是否是标签节点-->
  <block qq:if="{{item.node == 'element'}}">
    <block qq:if="{{item.tag == 'button'}}">
      <button type="default" size="mini">
        <block qq:for="{{item.nodes}}" qq:for-item="item" qq:key="">
          <template is="wxParse3" data="{{item}}" />
        </block>
      </button>
    </block>
    <!--li类型-->
    <block qq:elif="{{item.tag == 'li'}}">
      <view class="{{item.classStr}} wxParse-li" style="{{item.styleStr}}">
        <view class="{{item.classStr}} wxParse-li-inner">
          <view class="{{item.classStr}} wxParse-li-text">
            <view class="{{item.classStr}} wxParse-li-circle"></view>
          </view>
          <view class="{{item.classStr}} wxParse-li-text">
            <block qq:for="{{item.nodes}}" qq:for-item="item" qq:key="">
              <template is="wxParse3" data="{{item}}" />
            </block>
          </view>
        </view>
      </view>
    </block>

    <!--video类型-->
    <block qq:elif="{{item.tag == 'video'}}">
      <template is="wxParseVideo" data="{{item}}" />
    </block>

    <!--img类型-->
    <block qq:elif="{{item.tag == 'img'}}">
      <template is="wxParseImg" data="{{item}}" />
    </block>

    <!--a类型-->
    <block qq:elif="{{item.tag == 'a'}}">
      <view bindtap="wxParseTagATap" class="wxParse-inline {{item.classStr}} wxParse-{{item.tag}}" data-src="{{item.attr.href}}" style="{{item.styleStr}}">
        <block qq:for="{{item.nodes}}" qq:for-item="item" qq:key="">
          <template is="wxParse3" data="{{item}}" />
        </block>
      </view>
    </block>

    <block qq:elif="{{item.tag == 'br'}}">
      <template is="WxParseBr"></template>
    </block>
    <!--其他块级标签-->
    <block qq:elif="{{item.tagType == 'block'}}">
      <view class="{{item.classStr}} wxParse-{{item.tag}}" style="{{item.styleStr}}">
        <block qq:for="{{item.nodes}}" qq:for-item="item" qq:key="">
          <template is="wxParse3" data="{{item}}" />
        </block>
      </view>
    </block>

    <!--内联标签-->
    <view qq:else class="{{item.classStr}} wxParse-{{item.tag}} wxParse-{{item.tagType}}" style="{{item.styleStr}}">
      <block qq:for="{{item.nodes}}" qq:for-item="item" qq:key="">
        <template is="wxParse3" data="{{item}}" />
      </block>
    </view>

  </block>

  <!--判断是否是文本节点-->
  <block qq:elif="{{item.node == 'text'}}">
    <!--如果是，直接进行-->
    <template is="WxEmojiView" data="{{item}}" />
  </block>

</template>

<!--循环模版-->
<template name="wxParse3">
  <!--<template is="wxParse4" data="{{item}}" />-->
  <!--判断是否是标签节点-->
  <block qq:if="{{item.node == 'element'}}">
    <block qq:if="{{item.tag == 'button'}}">
      <button type="default" size="mini">
        <block qq:for="{{item.nodes}}" qq:for-item="item" qq:key="">
          <template is="wxParse4" data="{{item}}" />
        </block>
      </button>
    </block>
    <!--li类型-->
    <block qq:elif="{{item.tag == 'li'}}">
      <view class="{{item.classStr}} wxParse-li" style="{{item.styleStr}}">
        <view class="{{item.classStr}} wxParse-li-inner">
          <view class="{{item.classStr}} wxParse-li-text">
            <view class="{{item.classStr}} wxParse-li-circle"></view>
          </view>
          <view class="{{item.classStr}} wxParse-li-text">
            <block qq:for="{{item.nodes}}" qq:for-item="item" qq:key="">
              <template is="wxParse4" data="{{item}}" />
            </block>
          </view>
        </view>
      </view>
    </block>

    <!--video类型-->
    <block qq:elif="{{item.tag == 'video'}}">
      <template is="wxParseVideo" data="{{item}}" />
    </block>

    <!--img类型-->
    <block qq:elif="{{item.tag == 'img'}}">
      <template is="wxParseImg" data="{{item}}" />
    </block>

    <!--a类型-->
    <block qq:elif="{{item.tag == 'a'}}">
      <view bindtap="wxParseTagATap" class="wxParse-inline {{item.classStr}} wxParse-{{item.tag}}" data-src="{{item.attr.href}}" style="{{item.styleStr}}">
        <block qq:for="{{item.nodes}}" qq:for-item="item" qq:key="">
          <template is="wxParse4" data="{{item}}" />
        </block>
      </view>
    </block>

    <block qq:elif="{{item.tag == 'br'}}">
      <template is="WxParseBr"></template>
    </block>
    <!--其他块级标签-->
    <block qq:elif="{{item.tagType == 'block'}}">
      <view class="{{item.classStr}} wxParse-{{item.tag}}" style="{{item.styleStr}}">
        <block qq:for="{{item.nodes}}" qq:for-item="item" qq:key="">
          <template is="wxParse4" data="{{item}}" />
        </block>
      </view>
    </block>

    <!--内联标签-->
    <view qq:else class="{{item.classStr}} wxParse-{{item.tag}} wxParse-{{item.tagType}}" style="{{item.styleStr}}">
      <block qq:for="{{item.nodes}}" qq:for-item="item" qq:key="">
        <template is="wxParse4" data="{{item}}" />
      </block>
    </view>

  </block>

  <!--判断是否是文本节点-->
  <block qq:elif="{{item.node == 'text'}}">
    <!--如果是，直接进行-->
    <template is="WxEmojiView" data="{{item}}" />
  </block>

</template>

<!--循环模版-->
<template name="wxParse4">
  <!--<template is="wxParse5" data="{{item}}" />-->
  <!--判断是否是标签节点-->
  <block qq:if="{{item.node == 'element'}}">
    <block qq:if="{{item.tag == 'button'}}">
      <button type="default" size="mini">
        <block qq:for="{{item.nodes}}" qq:for-item="item" qq:key="">
          <template is="wxParse5" data="{{item}}" />
        </block>
      </button>
    </block>
    <!--li类型-->
    <block qq:elif="{{item.tag == 'li'}}">
      <view class="{{item.classStr}} wxParse-li" style="{{item.styleStr}}">
        <view class="{{item.classStr}} wxParse-li-inner">
          <view class="{{item.classStr}} wxParse-li-text">
            <view class="{{item.classStr}} wxParse-li-circle"></view>
          </view>
          <view class="{{item.classStr}} wxParse-li-text">
            <block qq:for="{{item.nodes}}" qq:for-item="item" qq:key="">
              <template is="wxParse5" data="{{item}}" />
            </block>
          </view>
        </view>
      </view>
    </block>

    <!--video类型-->
    <block qq:elif="{{item.tag == 'video'}}">
      <template is="wxParseVideo" data="{{item}}" />
    </block>

    <!--img类型-->
    <block qq:elif="{{item.tag == 'img'}}">
      <template is="wxParseImg" data="{{item}}" />
    </block>

    <!--a类型-->
    <block qq:elif="{{item.tag == 'a'}}">
      <view bindtap="wxParseTagATap" class="wxParse-inline {{item.classStr}} wxParse-{{item.tag}}" data-src="{{item.attr.href}}" style="{{item.styleStr}}">
        <block qq:for="{{item.nodes}}" qq:for-item="item" qq:key="">
          <template is="wxParse5" data="{{item}}" />
        </block>
      </view>
    </block>

    <block qq:elif="{{item.tag == 'br'}}">
      <template is="WxParseBr"></template>
    </block>
    <!--其他块级标签-->
    <block qq:elif="{{item.tagType == 'block'}}">
      <view class="{{item.classStr}} wxParse-{{item.tag}}" style="{{item.styleStr}}">
        <block qq:for="{{item.nodes}}" qq:for-item="item" qq:key="">
          <template is="wxParse5" data="{{item}}" />
        </block>
      </view>
    </block>

    <!--内联标签-->
    <view qq:else class="{{item.classStr}} wxParse-{{item.tag}} wxParse-{{item.tagType}}" style="{{item.styleStr}}">
      <block qq:for="{{item.nodes}}" qq:for-item="item" qq:key="">
        <template is="wxParse5" data="{{item}}" />
      </block>
    </view>

  </block>

  <!--判断是否是文本节点-->
  <block qq:elif="{{item.node == 'text'}}">
    <!--如果是，直接进行-->
    <template is="WxEmojiView" data="{{item}}" />
  </block>

</template>

<!--循环模版-->
<template name="wxParse5">
  <!--<template is="wxParse6" data="{{item}}" />-->
  <!--判断是否是标签节点-->
  <block qq:if="{{item.node == 'element'}}">
    <block qq:if="{{item.tag == 'button'}}">
      <button type="default" size="mini">
        <block qq:for="{{item.nodes}}" qq:for-item="item" qq:key="">
          <template is="wxParse6" data="{{item}}" />
        </block>
      </button>
    </block>
    <!--li类型-->
    <block qq:elif="{{item.tag == 'li'}}">
      <view class="{{item.classStr}} wxParse-li" style="{{item.styleStr}}">
        <view class="{{item.classStr}} wxParse-li-inner">
          <view class="{{item.classStr}} wxParse-li-text">
            <view class="{{item.classStr}} wxParse-li-circle"></view>
          </view>
          <view class="{{item.classStr}} wxParse-li-text">
            <block qq:for="{{item.nodes}}" qq:for-item="item" qq:key="">
              <template is="wxParse6" data="{{item}}" />
            </block>
          </view>
        </view>
      </view>
    </block>

    <!--video类型-->
    <block qq:elif="{{item.tag == 'video'}}">
      <template is="wxParseVideo" data="{{item}}" />
    </block>

    <!--img类型-->
    <block qq:elif="{{item.tag == 'img'}}">
      <template is="wxParseImg" data="{{item}}" />
    </block>

    <!--a类型-->
    <block qq:elif="{{item.tag == 'a'}}">
      <view bindtap="wxParseTagATap" class="wxParse-inline {{item.classStr}} wxParse-{{item.tag}}" data-src="{{item.attr.href}}" style="{{item.styleStr}}">
        <block qq:for="{{item.nodes}}" qq:for-item="item" qq:key="">
          <template is="wxParse6" data="{{item}}" />
        </block>
      </view>
    </block>

    <block qq:elif="{{item.tag == 'br'}}">
      <template is="WxParseBr"></template>
    </block>
    <!--其他块级标签-->
    <block qq:elif="{{item.tagType == 'block'}}">
      <view class="{{item.classStr}} wxParse-{{item.tag}}" style="{{item.styleStr}}">
        <block qq:for="{{item.nodes}}" qq:for-item="item" qq:key="">
          <template is="wxParse6" data="{{item}}" />
        </block>
      </view>
    </block>

    <!--内联标签-->
    <view qq:else class="{{item.classStr}} wxParse-{{item.tag}} wxParse-{{item.tagType}}" style="{{item.styleStr}}">
      <block qq:for="{{item.nodes}}" qq:for-item="item" qq:key="">
        <template is="wxParse6" data="{{item}}" />
      </block>
    </view>

  </block>

  <!--判断是否是文本节点-->
  <block qq:elif="{{item.node == 'text'}}">
    <!--如果是，直接进行-->
    <template is="WxEmojiView" data="{{item}}" />
  </block>

</template>

<!--循环模版-->
<template name="wxParse6">
  <!--<template is="wxParse7" data="{{item}}" />-->
  <!--判断是否是标签节点-->
  <block qq:if="{{item.node == 'element'}}">
    <block qq:if="{{item.tag == 'button'}}">
      <button type="default" size="mini">
        <block qq:for="{{item.nodes}}" qq:for-item="item" qq:key="">
          <template is="wxParse7" data="{{item}}" />
        </block>
      </button>
    </block>
    <!--li类型-->
    <block qq:elif="{{item.tag == 'li'}}">
      <view class="{{item.classStr}} wxParse-li" style="{{item.styleStr}}">
        <view class="{{item.classStr}} wxParse-li-inner">
          <view class="{{item.classStr}} wxParse-li-text">
            <view class="{{item.classStr}} wxParse-li-circle"></view>
          </view>
          <view class="{{item.classStr}} wxParse-li-text">
            <block qq:for="{{item.nodes}}" qq:for-item="item" qq:key="">
              <template is="wxParse7" data="{{item}}" />
            </block>
          </view>
        </view>
      </view>
    </block>

    <!--video类型-->
    <block qq:elif="{{item.tag == 'video'}}">
      <template is="wxParseVideo" data="{{item}}" />
    </block>

    <!--img类型-->
    <block qq:elif="{{item.tag == 'img'}}">
      <template is="wxParseImg" data="{{item}}" />
    </block>

    <!--a类型-->
    <block qq:elif="{{item.tag == 'a'}}">
      <view bindtap="wxParseTagATap" class="wxParse-inline {{item.classStr}} wxParse-{{item.tag}}" data-src="{{item.attr.href}}" style="{{item.styleStr}}">
        <block qq:for="{{item.nodes}}" qq:for-item="item" qq:key="">
          <template is="wxParse7" data="{{item}}" />
        </block>
      </view>
    </block>

    <block qq:elif="{{item.tag == 'br'}}">
      <template is="WxParseBr"></template>
    </block>
    <!--其他块级标签-->
    <block qq:elif="{{item.tagType == 'block'}}">
      <view class="{{item.classStr}} wxParse-{{item.tag}}" style="{{item.styleStr}}">
        <block qq:for="{{item.nodes}}" qq:for-item="item" qq:key="">
          <template is="wxParse7" data="{{item}}" />
        </block>
      </view>
    </block>

    <!--内联标签-->
    <view qq:else class="{{item.classStr}} wxParse-{{item.tag}} wxParse-{{item.tagType}}" style="{{item.styleStr}}">
      <block qq:for="{{item.nodes}}" qq:for-item="item" qq:key="">
        <template is="wxParse7" data="{{item}}" />
      </block>
    </view>

  </block>

  <!--判断是否是文本节点-->
  <block qq:elif="{{item.node == 'text'}}">
    <!--如果是，直接进行-->
    <template is="WxEmojiView" data="{{item}}" />
  </block>

</template>
<!--循环模版-->
<template name="wxParse7">
  <!--<template is="wxParse8" data="{{item}}" />-->
  <!--判断是否是标签节点-->
  <block qq:if="{{item.node == 'element'}}">
    <block qq:if="{{item.tag == 'button'}}">
      <button type="default" size="mini">
        <block qq:for="{{item.nodes}}" qq:for-item="item" qq:key="">
          <template is="wxParse8" data="{{item}}" />
        </block>
      </button>
    </block>
    <!--li类型-->
    <block qq:elif="{{item.tag == 'li'}}">
      <view class="{{item.classStr}} wxParse-li" style="{{item.styleStr}}">
        <view class="{{item.classStr}} wxParse-li-inner">
          <view class="{{item.classStr}} wxParse-li-text">
            <view class="{{item.classStr}} wxParse-li-circle"></view>
          </view>
          <view class="{{item.classStr}} wxParse-li-text">
            <block qq:for="{{item.nodes}}" qq:for-item="item" qq:key="">
              <template is="wxParse8" data="{{item}}" />
            </block>
          </view>
        </view>
      </view>
    </block>

    <!--video类型-->
    <block qq:elif="{{item.tag == 'video'}}">
      <template is="wxParseVideo" data="{{item}}" />
    </block>

    <!--img类型-->
    <block qq:elif="{{item.tag == 'img'}}">
      <template is="wxParseImg" data="{{item}}" />
    </block>

    <!--a类型-->
    <block qq:elif="{{item.tag == 'a'}}">
      <view bindtap="wxParseTagATap" class="wxParse-inline {{item.classStr}} wxParse-{{item.tag}}" data-src="{{item.attr.href}}" style="{{item.styleStr}}">
        <block qq:for="{{item.nodes}}" qq:for-item="item" qq:key="">
          <template is="wxParse8" data="{{item}}" />
        </block>
      </view>
    </block>

    <block qq:elif="{{item.tag == 'br'}}">
      <template is="WxParseBr"></template>
    </block>
    <!--其他块级标签-->
    <block qq:elif="{{item.tagType == 'block'}}">
      <view class="{{item.classStr}} wxParse-{{item.tag}}" style="{{item.styleStr}}">
        <block qq:for="{{item.nodes}}" qq:for-item="item" qq:key="">
          <template is="wxParse8" data="{{item}}" />
        </block>
      </view>
    </block>

    <!--内联标签-->
    <view qq:else class="{{item.classStr}} wxParse-{{item.tag}} wxParse-{{item.tagType}}" style="{{item.styleStr}}">
      <block qq:for="{{item.nodes}}" qq:for-item="item" qq:key="">
        <template is="wxParse8" data="{{item}}" />
      </block>
    </view>

  </block>

  <!--判断是否是文本节点-->
  <block qq:elif="{{item.node == 'text'}}">
    <!--如果是，直接进行-->
    <template is="WxEmojiView" data="{{item}}" />
  </block>

</template>

<!--循环模版-->
<template name="wxParse8">
  <!--<template is="wxParse9" data="{{item}}" />-->
  <!--判断是否是标签节点-->
  <block qq:if="{{item.node == 'element'}}">
    <block qq:if="{{item.tag == 'button'}}">
      <button type="default" size="mini">
        <block qq:for="{{item.nodes}}" qq:for-item="item" qq:key="">
          <template is="wxParse9" data="{{item}}" />
        </block>
      </button>
    </block>
    <!--li类型-->
    <block qq:elif="{{item.tag == 'li'}}">
      <view class="{{item.classStr}} wxParse-li" style="{{item.styleStr}}">
        <view class="{{item.classStr}} wxParse-li-inner">
          <view class="{{item.classStr}} wxParse-li-text">
            <view class="{{item.classStr}} wxParse-li-circle"></view>
          </view>
          <view class="{{item.classStr}} wxParse-li-text">
            <block qq:for="{{item.nodes}}" qq:for-item="item" qq:key="">
              <template is="wxParse9" data="{{item}}" />
            </block>
          </view>
        </view>
      </view>
    </block>

    <!--video类型-->
    <block qq:elif="{{item.tag == 'video'}}">
      <template is="wxParseVideo" data="{{item}}" />
    </block>

    <!--img类型-->
    <block qq:elif="{{item.tag == 'img'}}">
      <template is="wxParseImg" data="{{item}}" />
    </block>

    <!--a类型-->
    <block qq:elif="{{item.tag == 'a'}}">
      <view bindtap="wxParseTagATap" class="wxParse-inline {{item.classStr}} wxParse-{{item.tag}}" data-src="{{item.attr.href}}" style="{{item.styleStr}}">
        <block qq:for="{{item.nodes}}" qq:for-item="item" qq:key="">
          <template is="wxParse9" data="{{item}}" />
        </block>
      </view>
    </block>

    <block qq:elif="{{item.tag == 'br'}}">
      <template is="WxParseBr"></template>
    </block>
    <!--其他块级标签-->
    <block qq:elif="{{item.tagType == 'block'}}">
      <view class="{{item.classStr}} wxParse-{{item.tag}}" style="{{item.styleStr}}">
        <block qq:for="{{item.nodes}}" qq:for-item="item" qq:key="">
          <template is="wxParse9" data="{{item}}" />
        </block>
      </view>
    </block>

    <!--内联标签-->
    <view qq:else class="{{item.classStr}} wxParse-{{item.tag}} wxParse-{{item.tagType}}" style="{{item.styleStr}}">
      <block qq:for="{{item.nodes}}" qq:for-item="item" qq:key="">
        <template is="wxParse9" data="{{item}}" />
      </block>
    </view>

  </block>

  <!--判断是否是文本节点-->
  <block qq:elif="{{item.node == 'text'}}">
    <!--如果是，直接进行-->
    <template is="WxEmojiView" data="{{item}}" />
  </block>

</template>

<!--循环模版-->
<template name="wxParse9">
  <!--<template is="wxParse10" data="{{item}}" />-->
  <!--判断是否是标签节点-->
  <block qq:if="{{item.node == 'element'}}">
    <block qq:if="{{item.tag == 'button'}}">
      <button type="default" size="mini">
        <block qq:for="{{item.nodes}}" qq:for-item="item" qq:key="">
          <template is="wxParse10" data="{{item}}" />
        </block>
      </button>
    </block>
    <!--li类型-->
    <block qq:elif="{{item.tag == 'li'}}">
      <view class="{{item.classStr}} wxParse-li" style="{{item.styleStr}}">
        <view class="{{item.classStr}} wxParse-li-inner">
          <view class="{{item.classStr}} wxParse-li-text">
            <view class="{{item.classStr}} wxParse-li-circle"></view>
          </view>
          <view class="{{item.classStr}} wxParse-li-text">
            <block qq:for="{{item.nodes}}" qq:for-item="item" qq:key="">
              <template is="wxParse10" data="{{item}}" />
            </block>
          </view>
        </view>
      </view>
    </block>

    <!--video类型-->
    <block qq:elif="{{item.tag == 'video'}}">
      <template is="wxParseVideo" data="{{item}}" />
    </block>

    <!--img类型-->
    <block qq:elif="{{item.tag == 'img'}}">
      <template is="wxParseImg" data="{{item}}" />
    </block>

    <!--a类型-->
    <block qq:elif="{{item.tag == 'a'}}">
      <view bindtap="wxParseTagATap" class="wxParse-inline {{item.classStr}} wxParse-{{item.tag}}" data-src="{{item.attr.href}}" style="{{item.styleStr}}">
        <block qq:for="{{item.nodes}}" qq:for-item="item" qq:key="">
          <template is="wxParse10" data="{{item}}" />
        </block>
      </view>
    </block>

    <block qq:elif="{{item.tag == 'br'}}">
      <template is="WxParseBr"></template>
    </block>
    <!--其他块级标签-->
    <block qq:elif="{{item.tagType == 'block'}}">
      <view class="{{item.classStr}} wxParse-{{item.tag}}" style="{{item.styleStr}}">
        <block qq:for="{{item.nodes}}" qq:for-item="item" qq:key="">
          <template is="wxParse10" data="{{item}}" />
        </block>
      </view>
    </block>

    <!--内联标签-->
    <view qq:else class="{{item.classStr}} wxParse-{{item.tag}} wxParse-{{item.tagType}}" style="{{item.styleStr}}">
      <block qq:for="{{item.nodes}}" qq:for-item="item" qq:key="">
        <template is="wxParse10" data="{{item}}" />
      </block>
    </view>

  </block>

  <!--判断是否是文本节点-->
  <block qq:elif="{{item.node == 'text'}}">
    <!--如果是，直接进行-->
    <template is="WxEmojiView" data="{{item}}" />
  </block>

</template>

<!--循环模版-->
<template name="wxParse10">
  <!--<template is="wxParse11" data="{{item}}" />-->
  <!--判断是否是标签节点-->
  <block qq:if="{{item.node == 'element'}}">
    <block qq:if="{{item.tag == 'button'}}">
      <button type="default" size="mini">
        <block qq:for="{{item.nodes}}" qq:for-item="item" qq:key="">
          <template is="wxParse11" data="{{item}}" />
        </block>
      </button>
    </block>
    <!--li类型-->
    <block qq:elif="{{item.tag == 'li'}}">
      <view class="{{item.classStr}} wxParse-li" style="{{item.styleStr}}">
        <view class="{{item.classStr}} wxParse-li-inner">
          <view class="{{item.classStr}} wxParse-li-text">
            <view class="{{item.classStr}} wxParse-li-circle"></view>
          </view>
          <view class="{{item.classStr}} wxParse-li-text">
            <block qq:for="{{item.nodes}}" qq:for-item="item" qq:key="">
              <template is="wxParse11" data="{{item}}" />
            </block>
          </view>
        </view>
      </view>
    </block>

    <!--video类型-->
    <block qq:elif="{{item.tag == 'video'}}">
      <template is="wxParseVideo" data="{{item}}" />
    </block>

    <!--img类型-->
    <block qq:elif="{{item.tag == 'img'}}">
      <template is="wxParseImg" data="{{item}}" />
    </block>

    <!--a类型-->
    <block qq:elif="{{item.tag == 'a'}}">
      <view bindtap="wxParseTagATap" class="wxParse-inline {{item.classStr}} wxParse-{{item.tag}}" data-src="{{item.attr.href}}" style="{{item.styleStr}}">
        <block qq:for="{{item.nodes}}" qq:for-item="item" qq:key="">
          <template is="wxParse11" data="{{item}}" />
        </block>
      </view>
    </block>

    <block qq:elif="{{item.tag == 'br'}}">
      <template is="WxParseBr"></template>
    </block>
    <!--其他块级标签-->
    <block qq:elif="{{item.tagType == 'block'}}">
      <view class="{{item.classStr}} wxParse-{{item.tag}}" style="{{item.styleStr}}">
        <block qq:for="{{item.nodes}}" qq:for-item="item" qq:key="">
          <template is="wxParse11" data="{{item}}" />
        </block>
      </view>
    </block>

    <!--内联标签-->
    <view qq:else class="{{item.classStr}} wxParse-{{item.tag}} wxParse-{{item.tagType}}" style="{{item.styleStr}}">
      <block qq:for="{{item.nodes}}" qq:for-item="item" qq:key="">
        <template is="wxParse11" data="{{item}}" />
      </block>
    </view>

  </block>

  <!--判断是否是文本节点-->
  <block qq:elif="{{item.node == 'text'}}">
    <!--如果是，直接进行-->
    <template is="WxEmojiView" data="{{item}}" />
  </block>

</template>

<!--循环模版-->
<template name="wxParse11">
  <!--<template is="wxParse12" data="{{item}}" />-->
  <!--判断是否是标签节点-->
  <block qq:if="{{item.node == 'element'}}">
    <block qq:if="{{item.tag == 'button'}}">
      <button type="default" size="mini">
        <block qq:for="{{item.nodes}}" qq:for-item="item" qq:key="">
          <template is="wxParse12" data="{{item}}" />
        </block>
      </button>
    </block>
    <!--li类型-->
    <block qq:elif="{{item.tag == 'li'}}">
      <view class="{{item.classStr}} wxParse-li" style="{{item.styleStr}}">
        <view class="{{item.classStr}} wxParse-li-inner">
          <view class="{{item.classStr}} wxParse-li-text">
            <view class="{{item.classStr}} wxParse-li-circle"></view>
          </view>
          <view class="{{item.classStr}} wxParse-li-text">
            <block qq:for="{{item.nodes}}" qq:for-item="item" qq:key="">
              <template is="wxParse12" data="{{item}}" />
            </block>
          </view>
        </view>
      </view>
    </block>

    <!--video类型-->
    <block qq:elif="{{item.tag == 'video'}}">
      <template is="wxParseVideo" data="{{item}}" />
    </block>

    <!--img类型-->
    <block qq:elif="{{item.tag == 'img'}}">
      <template is="wxParseImg" data="{{item}}" />
    </block>

    <!--a类型-->
    <block qq:elif="{{item.tag == 'a'}}">
      <view bindtap="wxParseTagATap" class="wxParse-inline {{item.classStr}} wxParse-{{item.tag}}" data-src="{{item.attr.href}}" style="{{item.styleStr}}">
        <block qq:for="{{item.nodes}}" qq:for-item="item" qq:key="">
          <template is="wxParse12" data="{{item}}" />
        </block>
      </view>
    </block>

    <block qq:elif="{{item.tag == 'br'}}">
      <template is="WxParseBr"></template>
    </block>
    <!--其他块级标签-->
    <block qq:elif="{{item.tagType == 'block'}}">
      <view class="{{item.classStr}} wxParse-{{item.tag}}" style="{{item.styleStr}}">
        <block qq:for="{{item.nodes}}" qq:for-item="item" qq:key="">
          <template is="wxParse12" data="{{item}}" />
        </block>
      </view>
    </block>

    <!--内联标签-->
    <view qq:else class="{{item.classStr}} wxParse-{{item.tag}} wxParse-{{item.tagType}}" style="{{item.styleStr}}">
      <block qq:for="{{item.nodes}}" qq:for-item="item" qq:key="">
        <template is="wxParse12" data="{{item}}" />
      </block>
    </view>

  </block>

  <!--判断是否是文本节点-->
  <block qq:elif="{{item.node == 'text'}}">
    <!--如果是，直接进行-->
    <template is="WxEmojiView" data="{{item}}" />
  </block>

</template>