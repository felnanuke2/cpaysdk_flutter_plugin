package com.centerm.cpaysdk_flutter_plugin

/**
 * @Description:
 * @Author:         daizy
 * @Date:     9/27/21 2:24 PM
 */
class EmvProcessEvent {
    var name: String? = null;
    var tipTitle: String? = null
    var tipContent: String? = null
    var aids: List<String>? = null
    var cardNo: String? = null
    var isOnlinePin: Boolean? =null
    var amount: String? = null
    var type: Int? = null
    var authContent: String? = null
    var finalAid: String? = null
    var transResult:Byte? = null
    var resultContent:String? = null

    var errorId: Int? = null
    var errorMsg: String? = null
}