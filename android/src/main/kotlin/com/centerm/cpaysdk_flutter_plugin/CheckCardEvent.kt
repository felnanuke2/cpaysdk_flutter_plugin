package com.centerm.cpaysdk_flutter_plugin

import com.pos.sdk.emv.CommonTrackData
import com.pos.sdk.magcard.TrackData

/**
 * @Description:
 * @Author:         daizy
 * @Date:     9/27/21 2:24 PM
 */
class CheckCardEvent {
    var name: String? = null
    var trackData: TrackData? = null
    var errorCode :Int?=null
    var errorMsg :String?=null
}