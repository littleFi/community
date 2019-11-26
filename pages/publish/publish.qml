<text class="select" bindtap="goToCorporation">{{corpName}}</text>
<view class="container column">
    <form bindsubmit="publish">
        <view class="box column">
            <textarea name="content" class="publish" value="{{content}}" bindblur='bindTextAreaBlur' placeholder-class="placeholder" auto-height placeholder="分享新鲜事" />

            <view class="image-content row">
                <image src="{{item}}" class="image" qq:for="{{images}}" qq:key="{{index}}"></image>
                <view class="image-btn" bindtap="choose">
                    <image src="../../images/dynamic/camera.png" class="camera"></image>
                </view>
            </view>
        </view>
        <view class="options">
            <!--<radio check="{{checked}}" class="radio"  color="#ABDA72" bindtap="radioCheck" />-->
            <!--<text class="radio-name">官方动态</text>-->
            <label catchtap='checkedTap'>
                <radio checked="{{checked}}" style="color:#aeaeae;font-size:28rpx;vertical-align: middle">官方动态</radio>
            </label>
        </view>

        <view class="btn-container">
            <button form-type="submit" class="publish-btn">发表动态</button>
            <!--<text  bindtap="publish">发表动态</text>-->
        </view>
    </form>
</view>