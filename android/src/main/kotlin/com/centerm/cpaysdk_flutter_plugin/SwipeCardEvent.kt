package com.centerm.cpaysdk_flutter_plugin

import com.pos.sdk.magcard.TrackData

/**
 * @Description:
 * @Author:         huangmin
 * @Date:     9/27/21 2:24 PM
 */
class SwipeCardEvent {
    var name: String? = null
    var trackData: TrackData? = null
    var errorCode :Int?=null
}