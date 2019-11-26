import {
    wxRequest
} from '../utils/wxRequest';

//社团信息
export const corporationInfo = (params) => wxRequest(params, '/corporation/corp/get/corp/msg/5');

//写留言
export const writeMessage = (params) => wxRequest(params, '/corporation/message/board/write/note');

//获取留言板列表
export const getMessage = (params,id,page) => wxRequest(params, '/corporation/message/board/static/get/notes/'+id+"/"+page)

//关注
export const follow = (params, id) => wxRequest(params, '/corporation/focus/corp/focus/'+id);

//单个文章
export const article = (params,id) => wxRequest(params, '/corporation/article/static/simple/'+id);

//点赞
export const like = (params,id) => wxRequest(params, '/corporation/article/praise/article/'+id);

//获取一级评论列表
export const comments = (params,id,page) => wxRequest(params, '/corporation/first/article/comment/static/get/comment/'+id+"/"+page)

//写一级评论
export const writeComment = (params) => wxRequest(params, '/corporation/first/article/comment/write/comment')

//更新用户头像 POST
export const updateHeadImg = (params) => wxRequest(params, '/auth/user/handle/user/info/update/headurl')

//更新用户昵称 GET
export const updateNickName = (params,nickname) => wxRequest(params, '/auth/user/handle/user/info/update/nickName/'+nickname)

//获取社团文章
export const articleList = (params,id,page) => wxRequest(params, '/corporation/article/static/articles/'+id+"/"+page)

//获取登陆人员社团动态
export const dynamic = (params, id, page) => wxRequest(params, '/communication/situation/situations/'+id+'/'+page)

//动态点赞
export const dynamicLike = (params,dynamicId) => wxRequest(params, '/communication/situation/praise/situation/'+dynamicId)

//获取动态详细
export const dynamicDetail = (params, dynamicId) => wxRequest(params, '/communication/situation/static/simple/' + dynamicId)

//动态评论
export const dynamicComment = (params) => wxRequest(params, '/communication/first/Situation/comment/write/comment')

//获取一级评论
export const getDynamicComment = (params,dynamicId,page) => wxRequest(params, '/communication/first/Situation/comment/static/get/comment/'+dynamicId+'/'+page)

//获取评论的回复
export const getReplyComment = (params,commentId,page) => wxRequest(params, '/communication/second/situation/comment/static/get/comment/'+commentId+'/'+page)

//对动态评论的回复
export const replyComment = (params) => wxRequest(params, '/communication/second/situation/comment/write/comment')

//个人扩展信息（“我的”页面）
export const people = (params) => wxRequest(params, '/user-info/user/info/ex/get/info/ex')

//个人全部信息
export const mine = (params) => wxRequest(params, '/auth/user/handle/user/info/get/all/')

//首页
export const home = (params) => wxRequest(params, '/common/member/count/static/get/daily/global')

//根据学校id获取社团数
export const getCommunity = (params,page,school) => wxRequest(params, '/corporation/corp/static/all/'+page+'/'+school)

//获取全部社团
export const getCorp = (params, page) => wxRequest(params, '/corporation/corp/static/all/'+page)

//获取社区榜的排名
export const getRank = (params,page) => wxRequest(params, '/corporation/rank/corp/static/rank/' + page)

//学校列表
export const school = (params) => wxRequest(params, '/corporation/school/static/get/all/0/')

//个人标签
export const label = (params,userId) => wxRequest(params, '/auth/userlabel/static/get/user/label/'+userId)

//信息搜集
export const memberCount = (params) => wxRequest(params, '/common/member/count/update/')

//取消关注
export const cancelFocus = (params, corpId) => wxRequest(params, '/corporation/focus/corp/unfocus/' + corpId)

//发表个人动态
export const publish = (params) => wxRequest(params, '/communication/situation/write/singleSituation')

//发表社团动态
export const corpPublish = (params) => wxRequest(params, '/communication/situation/write/corpSituation')

//获取所有动态
export const getAllDynamic = (params, page) => wxRequest(params, '/communication/situation/static/all/' + page)

//个人加入的社团
export const getPeopleCorp = (params) => wxRequest(params, '/corporation/corp/self/corp')

//更新个人简介
export const setIntroduction = (params) => wxRequest(params, '/auth/user/handle/user/info/self/introduction')