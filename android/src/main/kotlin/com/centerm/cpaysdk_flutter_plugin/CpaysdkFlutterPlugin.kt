package com.centerm.cpaysdk_flutter_plugin

import android.os.Bundle
import android.os.Handler
import android.util.Log
import androidx.annotation.NonNull
import com.google.gson.Gson
import com.pos.sdk.DeviceManager
import com.pos.sdk.DevicesFactory
import com.pos.sdk.callback.ResultCallback
import com.pos.sdk.dock.DockConnectType
import com.pos.sdk.emv.*
import com.pos.sdk.led.LedColor
import com.pos.sdk.magcard.IMagCardListener
import com.pos.sdk.magcard.TrackData
import com.pos.sdk.pinpad.*
import com.pos.sdk.printer.param.*
import com.pos.sdk.scan.IScanCallback
import com.pos.sdk.scan.IScanner
import com.pos.sdk.serialport.SerialPortParameter
import com.pos.sdk.sys.FinishListener
import com.pos.util.HexUtils
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.lang.reflect.InvocationTargetException
import java.lang.reflect.Method


/** CpaysdkFlutterPlugin */
class
CpaysdkFlutterPlugin : FlutterPlugin, MethodCallHandler {
    private val TAG = "CpaysdkFlutterPlugin"

    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var methodChannel: MethodChannel
    private var device: DeviceManager? = null
    private var gson: Gson? = null
    private var eventSink: EventChannel.EventSink? = null
    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        Log.d("@@@", "onAttachedToEngine: ")
        methodChannel =
            MethodChannel(flutterPluginBinding.binaryMessenger, "cpaysdk_flutter_plugin")
        methodChannel.setMethodCallHandler(this)

        DevicesFactory.create(
            flutterPluginBinding.applicationContext,
            object : ResultCallback<DeviceManager?> {
                override fun onFinish(p0: DeviceManager?) {
                    Log.d("@@@", "onAttachedToEngine: $p0")
                    device = p0
                }

                override fun onError(p0: Int, p1: String?) {
                    Log.e("@@@", "onError: ${p0},${p1}")
                }
            })
        gson = Gson()
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        Log.d("TAG", "onMethodCall: come in " + call.method)
        try {
            val method: Method = this.javaClass.getDeclaredMethod(
                call.method,
                MethodCall::class.java,
                Result::class.java
            )
            method.isAccessible = true
            method.invoke(this, call, result)
        } catch (e: NoSuchMethodException) {
            result.notImplemented()
        } catch (e: IllegalAccessException) {
            result.notImplemented()
        } catch (e: InvocationTargetException) {
            e.printStackTrace()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        methodChannel.setMethodCallHandler(null)
    }


    private fun inet4Address(@NonNull call: MethodCall, @NonNull result: Result) {
        val ipAddrress = device?.systemDevice?.inet4Address
        result.success(ipAddrress)
    }

    private fun hardwareAddress(@NonNull call: MethodCall, @NonNull result: Result) {
        val macAddrress = device?.systemDevice?.hardwareAddress
        result.success(macAddrress)
    }

    private fun ethInet4Address(@NonNull call: MethodCall, @NonNull result: Result) {
        val ipAddrress2 = device?.systemDevice?.ethInet4Address
        result.success(ipAddrress2)
    }

    private fun ethHardwareAddress(@NonNull call: MethodCall, @NonNull result: Result) {
        val macAddrress2 = device?.systemDevice?.ethHardwareAddress
        result.success(macAddrress2)
    }

    private fun install(@NonNull call: MethodCall, @NonNull result: Result) {
        Log.d("TAG", "onMethodCall: install " + call.arguments())
        try {
            device?.systemDevice?.installApkBack(
                call.argument("path"),
                object : FinishListener.Stub() {
                    override fun onFinished() {
                        result.success("success")
                    }

                    override fun onError(p0: Int, p1: String?) {
                        result.error(p0.toString(), p1, null)
                    }
                })
        } catch (e: Exception) {
            e.printStackTrace()
            result.error(e.message ?: "undefined", e.message, e.message)
        }
    }

    private fun uninstall(@NonNull call: MethodCall, @NonNull result: Result) {
        device?.systemDevice?.uninstallApkBack(
            call.argument("package"),
            object : FinishListener.Stub() {
                override fun onFinished() {
                    result.success("success")
                }

                override fun onError(p0: Int, p1: String?) {
                    result.error(p0.toString(), p1, null)
                }

            })
    }

    private fun lcdOn(@NonNull call: MethodCall, @NonNull result: Result) {
        device?.systemDevice?.lcdOn()
        result.success(null)
    }

    private fun lcdOff(@NonNull call: MethodCall, @NonNull result: Result) {
        device?.systemDevice?.lcdOff()
        result.success(null)
    }

    private fun reboot(@NonNull call: MethodCall, @NonNull result: Result) {
        device?.systemDevice?.reboot()
        result.success(null)
    }

    private fun setSystemTime(@NonNull call: MethodCall, @NonNull result: Result) {
        val ret: Boolean? =
            device?.systemDevice?.setSystemTime(call.argument<String>("time")?.toLong()!!)
        ret?.let {
            if (it) {
                result.success(null)
            } else {
                result.error("error", "error", null)
            }
        }
    }

    fun getPrinterState(@NonNull call: MethodCall, @NonNull result: Result) {
        result.success(device?.printDevice?.printerState?.stateCode)
    }

    fun setPrinterGray(@NonNull call: MethodCall, @NonNull result: Result) {
        device?.printDevice?.setPrinterGray(call.argument("gray")!!)
        result.success(null)
    }

    fun addTextPrintItem(@NonNull call: MethodCall, @NonNull result: Result) {
        Log.d("@@@", "addTextPrintItem data: " + call.argument<String>("text"))
        val printItemParam =
            gson?.fromJson(call.argument<String>("text"), TextPrintItemParam::class.java)!!
        Log.d("@@@", "json obj: $printItemParam")
        device?.printDevice?.addTextPrintItem(printItemParam)
        result.success(null)
    }

    fun addMultipleTextPrintItem(@NonNull call: MethodCall, @NonNull result: Result) {
        Log.d("@@@", "addMultipleTextPrintItem data: " + call.argument<String>("textList"))
        device?.printDevice?.addMultipleTextPrintItem(
            gson?.fromJson(
                call.argument<String>("textList"),
                MultipleTextPrintItemParam::class.java
            )!!
        )
        result.success(null)
    }

    fun addBitmapPrintItem(@NonNull call: MethodCall, @NonNull result: Result) {
        device?.printDevice?.addBitmapPrintItem(
            gson?.fromJson(
                call.argument<String>("bitmap"),
                BitmapPrintItemParam::class.java
            )!!
        )
        result.success(null)
    }

    fun addBarCodePrintItem(@NonNull call: MethodCall, @NonNull result: Result) {
        device?.printDevice?.addBarCodePrintItem(
            gson?.fromJson(
                call.argument<String>("barcode"),
                BarCodePrintItemParam::class.java
            )!!
        )
        result.success(null)
    }

    fun addQrPrintItemParam(@NonNull call: MethodCall, @NonNull result: Result) {
        device?.printDevice?.addQrPrintItemParam(
            gson?.fromJson(
                call.argument<String>("qrcode"),
                QrPrintItemParam::class.java
            )!!
        )
        result.success(null)
    }

    fun clearBufferArea(@NonNull call: MethodCall, @NonNull result: Result) {
        device?.printDevice?.clearBufferArea()
        result.success(null)
    }

    fun printSync(@NonNull call: MethodCall, @NonNull result: Result) {
        Log.d("TAG", "onMethodCall: printSync")
        result.success(device?.printDevice?.printSync(null)?.let { gson?.toJson(it) })
    }

    fun halt(@NonNull call: MethodCall, @NonNull result: Result) {
        device?.icDevice?.halt()
        result.success(null)
    }

    fun reset(@NonNull call: MethodCall, @NonNull result: Result) {
        result.success(device?.icDevice?.reset())
    }

    fun send(@NonNull call: MethodCall, @NonNull result: Result) {
        result.success(device?.icDevice?.send(call.argument("data")))
    }

    fun exists(@NonNull call: MethodCall, @NonNull result: Result) {
        result.success(device?.icDevice?.exists())
    }

    fun rfHalt(@NonNull call: MethodCall, @NonNull result: Result) {
        result.success(device?.rfDevice?.halt())
    }

    fun readCardType(@NonNull call: MethodCall, @NonNull result: Result) {
        result.success(device?.rfDevice?.readCardType())
    }

    fun rfReset(@NonNull call: MethodCall, @NonNull result: Result) {
        result.success(device?.rfDevice?.reset())
    }

    fun rfSend(@NonNull call: MethodCall, @NonNull result: Result) {
        result.success(device?.rfDevice?.send(call.argument("data")))
    }

    fun rfExists(@NonNull call: MethodCall, @NonNull result: Result) {
        result.success(device?.rfDevice?.exists())
    }

    fun resetCard(@NonNull call: MethodCall, @NonNull result: Result) {
        result.success(device?.rfDevice?.resetCard(call.argument("cardType")!!))
    }

    fun swipeCard(@NonNull call: MethodCall, @NonNull result: Result) {
        val handler = Handler()
        val timeout = call.argument<Int>("timeout")
        val isBeep = call.argument<Boolean>("beep")
        device?.magneticDevice?.swipeCard(timeout!!, isBeep!!, object : IMagCardListener.Stub() {
            override fun onSwipeCardSuccess(p0: TrackData?) {
                val swipeEvent = SwipeCardEvent()
                swipeEvent.name = "onSwipeCardSuccess"
                swipeEvent.trackData = p0
                handler.post {
                    methodChannel.invokeMethod(
                        "onSwipeCardEvent",
                        gson?.toJson(swipeEvent)
                    )
                }
            }

            override fun onSwipeCardException(p0: Int) {
                val swipeEvent = SwipeCardEvent()
                swipeEvent.name = "onSwipeCardException"
                swipeEvent.errorCode = p0
                handler.post {
                    methodChannel.invokeMethod(
                        "onSwipeCardEvent",
                        gson?.toJson(swipeEvent)
                    )
                }
            }

            override fun onCancelSwipeCard() {
                val swipeEvent = SwipeCardEvent()
                swipeEvent.name = "onCancelSwipeCard"
                handler.post {
                    methodChannel.invokeMethod(
                        "onSwipeCardEvent",
                        gson?.toJson(swipeEvent)
                    )
                }
            }

            override fun onSwipeCardTimeout() {
                val swipeEvent = SwipeCardEvent()
                swipeEvent.name = "onSwipeCardTimeout"
                handler.post {
                    methodChannel.invokeMethod(
                        "onSwipeCardEvent",
                        gson?.toJson(swipeEvent)
                    )
                }
            }

            override fun onSwipeCardFail() {
                val swipeEvent = SwipeCardEvent()
                swipeEvent.name = "onSwipeCardFail"
                handler.post {
                    methodChannel.invokeMethod(
                        "onSwipeCardEvent",
                        gson?.toJson(swipeEvent)
                    )
                }
            }

        })
        result.success(null)
    }

    fun stopSwipeCard(@NonNull call: MethodCall, @NonNull result: Result) {
        device?.magneticDevice?.stopSwipeCard()
        result.success(null)
    }

    fun beep(@NonNull call: MethodCall, @NonNull result: Result) {
        device?.beepDevice?.beep(call.argument("type")!!)
        result.success(null)
    }

    fun scan(@NonNull call: MethodCall, @NonNull result: Result) {
        val handler = Handler()
        val bundle = Bundle()
        with(bundle) {
            putInt(IScanner.CAMERA_ID, 1)
            putBoolean(IScanner.TORCH, false)
            putInt(IScanner.TIMEOUT, 60_000)
            putBoolean(IScanner.BEEP, true)
            putBoolean(IScanner.CONTINUOUS, false)
        }
        device?.scanDevice?.scan(bundle, object : IScanCallback.Stub() {
            override fun onSuccess(bytes: ByteArray?) {
                val event = ScanEvent()
                event.name = "onScanSuccess"
                event.scanCode = bytes?.let { String(it) }
                handler.post { methodChannel.invokeMethod("onScanEvent", gson?.toJson(event)) }
            }

            override fun onFailed(p0: Int, p1: String?) {
                val event = ScanEvent();
                event.name = "onScanFailed"
                event.errorMsg = p1
                event.errorCode = p0
                handler.post { methodChannel.invokeMethod("onScanEvent", gson?.toJson(event)) }
            }
        })
        result.success(null)
    }

    fun autoStopScan(@NonNull call: MethodCall, @NonNull result: Result) {
        val handler = Handler()
        scan(call, result)
        handler.postDelayed({ kotlin.run { device?.scanDevice?.stopScan() } }, 5000)
        result.success(null)
    }

    fun loadTek(@NonNull call: MethodCall, @NonNull result: Result) {
        val tekId = call.argument<Int>("tek_id")!!
        val tek = call.argument<ByteArray>("tek")!!

        var checkValue: ByteArray? = null
        if (call.hasArgument("check_value")) {
            checkValue = call.argument<ByteArray>("check_value")
        }

        val tekBytes = HexUtils.hexStringToByte(String(tek))
        var loadTek: Boolean? = null
        if (checkValue == null) {
            loadTek = device?.pinpadDevice?.loadTek(tekId, tekBytes)
        } else {
            loadTek = device?.pinpadDevice?.loadTek(tekId, tekBytes, checkValue)
        }
        result.success(loadTek)
    }

    fun loadTmk(@NonNull call: MethodCall, @NonNull result: Result) {
        val tekId = call.argument<Int>("tek_id")!!
        val tmkId = call.argument<Int>("tmk_id")!!
        val tmk = call.argument<ByteArray>("tmk")!!
        var checkValue: ByteArray? = null

        if (call.hasArgument("check_value")) {
            val checkValue = call.argument<ByteArray>("check_value")
        }

        var loadTmk: Boolean? = null
        val tmkBytes = HexUtils.hexStringToByte(String(tmk))
        if (checkValue == null) {
            loadTmk = device?.pinpadDevice?.loadTekEncryptedTmk(tekId, tmkId, tmkBytes)
        } else {
            val cvBytes = HexUtils.hexStringToByte(String(checkValue))
            loadTmk = device?.pinpadDevice?.loadTekEncryptedTmk(tekId, tmkId, tmkBytes, cvBytes)
        }
        result.success(loadTmk)
    }


    fun loadPik(@NonNull call: MethodCall, @NonNull result: Result) {
        val tmkId = call.argument<Int>("tmk_id")!!
        val pikId = call.argument<Int>("pik_id")!!
        val pik = call.argument<ByteArray>("pik")!!
        var checkValue: ByteArray? = null
        if (call.hasArgument("check_value")) {
            checkValue = call.argument<ByteArray>("check_value")
        }

        Log.i(TAG, "loadPik: pik = " + String(pik))

        var loadPik: Boolean? = null
        val pikBytes = HexUtils.hexStringToByte(String(pik))
        if (checkValue == null) {
            loadPik = device?.pinpadDevice?.loadTmkEncryptedPik(tmkId, pikId, pikBytes)
        } else {
            val cvBytes = HexUtils.hexStringToByte(String(checkValue))
            loadPik = device?.pinpadDevice?.loadTmkEncryptedPik(tmkId, pikId, pik, cvBytes)
        }
        result.success(loadPik)
    }

    fun loadMak(@NonNull call: MethodCall, @NonNull result: Result) {
        val tmkId = call.argument<Int>("tmk_id")!!
        val makId = call.argument<Int>("mak_id")!!
        val mak = call.argument<ByteArray>("mak")!!
        var checkValue: ByteArray? = null
        if (call.hasArgument("check_value")) {
            checkValue = call.argument<ByteArray>("check_value")
        }

        Log.i(TAG, "loadMak: mak = " + String(mak))

        var loadMak: Boolean? = null
        val makBytes = HexUtils.hexStringToByte(String(mak))
        if (checkValue == null) {
            loadMak = device?.pinpadDevice?.loadTmkEncryptedMak(tmkId, makId, makBytes)
        } else {
            val cvBytes = HexUtils.hexStringToByte(String(checkValue))
            loadMak = device?.pinpadDevice?.loadTmkEncryptedMak(tmkId, makId, mak, cvBytes)
        }
        result.success(loadMak)
    }

    fun loadTdk(@NonNull call: MethodCall, @NonNull result: Result) {
        val tmkId = call.argument<Int>("tmk_id")!!
        val tdkId = call.argument<Int>("tdk_id")!!
        val tdk = call.argument<ByteArray>("tdk")!!
        var checkValue: ByteArray? = null
        if (call.hasArgument("check_value")) {
            checkValue = call.argument<ByteArray>("check_value")
        }

        Log.i(TAG, "loadTdk: tdk = " + String(tdk))

        var loadTdk: Boolean? = null
        val tdkBytes = HexUtils.hexStringToByte(String(tdk))
        if (checkValue == null) {
            loadTdk = device?.pinpadDevice?.loadTmkEncryptedTdk(tmkId, tdkId, tdkBytes)
        } else {
            val cvBytes = HexUtils.hexStringToByte(String(checkValue))
            loadTdk = device?.pinpadDevice?.loadTmkEncryptedTdk(tmkId, tdkId, tdk, cvBytes)
        }
        result.success(loadTdk)
    }

    fun loadTmkPlant(@NonNull call: MethodCall, @NonNull result: Result) {
        val tmkId = call.argument<Int>("tmk_id")!!
        val tmk = call.argument<ByteArray>("tmk")!!
        val loadTmkPlant = device?.pinpadDevice?.loadTmk(tmkId, tmk)
        result.success(loadTmkPlant)
    }

    fun getPinBlock(@NonNull call: MethodCall, @NonNull result: Result) {
        Log.d(TAG, "getPinBlock: ")
        val flutterPinInfo =
            gson?.fromJson(call.argument<String>("pinInfo"), FlutterPinInfo::class.java)!!

        val info = PinPadInfo.builder(flutterPinInfo?.cardno!!)
            .setPikId(flutterPinInfo?.pikId!!)
            .setKeyType(PinPadInfo.KeyType.values()[flutterPinInfo?.keytype!!])
            .setMinLength(flutterPinInfo?.minLenth!!)
            .setMaxLength(flutterPinInfo?.maxLenth!!)
            .setEncrpyMode(PinPadInfo.EncrpyMode.values()[flutterPinInfo?.encryMode!!])
            .setNeedCardCalc(true)
            .setInputTimes(PinPadInfo.InputTimes.values()[flutterPinInfo?.inputTimes!!])
            .setCancelable(flutterPinInfo?.isCanclable!!)
            .setBeep(flutterPinInfo?.isBeep!!)
            .setTimeout(flutterPinInfo?.timeout!!)
            .setShowInputBox(flutterPinInfo?.isShowInputBox!!)
            .setUseRandomKeybord(flutterPinInfo?.isRandomKeybord!!)
            .setShowMask(true)
            .build()

        val handler = Handler()
        device?.pinpadDevice?.getPin(info!!, object : IPinPadPinCallback.Stub() {
            override fun onReadingPin(p0: Int, p1: String?) {
                val event = PinpadEvent()
                event.name = "onReadingPin"
                event.len = p0
                event.inputItem = p1
                handler.post { methodChannel.invokeMethod("OnPinpadEvent", gson?.toJson(event)) }
            }

            override fun onReadPinCancel() {
                val event = PinpadEvent()
                event.name = "onReadPinCancel"
                handler.post { methodChannel.invokeMethod("OnPinpadEvent", gson?.toJson(event)) }
            }

            override fun onReadPinSuccess(p0: ByteArray?) {
                val event = PinpadEvent()
                event.name = "onReadPinSuccess"
                event.pinBlock = HexUtils.bcd2str(p0)
                handler.post { methodChannel.invokeMethod("OnPinpadEvent", gson?.toJson(event)) }
            }

            override fun onError(p0: Int, p1: String?) {
                val event = PinpadEvent()
                event.name = "onError"
                event.errorId = p0
                event.errorMsg = p1
                handler.post { methodChannel.invokeMethod("OnPinpadEvent", gson?.toJson(event)) }
            }
        })

        result.success(null)
    }

    fun getMac(@NonNull call: MethodCall, @NonNull result: Result) {
        val type = call.argument<Int>("mac_type")
        val data = call.argument<String>("data")
        val mode = call.argument<Int>("mac_mode")
        val makId = call.argument<Int>("mak_id")

        val info = PinPadMacInfo.builder(makId!!, HexUtils.hexStringToByte(data!!))
            .setMacMode(PinPadMacInfo.MacMode.values()[mode!!])
            .setMacType(PinPadMacInfo.MacType.values()[type!!])
            .build()
        val mac = device?.pinpadDevice?.getMac(info)
        if (mac != null && mac.isNotEmpty()) {
            result.success(HexUtils.bcd2str(mac))
        } else {
            result.success(null)
        }
    }

    fun getEncData(@NonNull call: MethodCall, @NonNull result: Result) {
        val data = call.argument<String>("data")
        val mode = call.argument<Boolean>("mode")
        val tdkId = call.argument<Int>("tdk_id")

        val encData = device?.pinpadDevice?.encryptDataByTdk(
            tdkId!!,
            HexUtils.hexStringToByte(data!!),
            mode!!
        )
        if (encData != null && encData.isNotEmpty()) {
            result.success(HexUtils.bcd2str(encData))
        } else {
            result.success(null)
        }
    }

    fun getDecryptedData(@NonNull call: MethodCall, @NonNull result: Result) {
        val data = call.argument<String>("data")
        val mode = call.argument<Boolean>("mode")
        val tdkId = call.argument<Int>("tdk_id")

        val decData = device?.pinpadDevice?.decryptDataByTdk(
            tdkId!!,
            HexUtils.hexStringToByte(data!!),
            mode!!
        )
        if (decData != null && decData.isNotEmpty()) {
            result.success(HexUtils.bcd2str(decData))
        } else {
            result.success(null)
        }
    }

    fun getRandom(@NonNull call: MethodCall, @NonNull resule: Result) {
        resule.success(HexUtils.bcd2str(device?.pinpadDevice?.random))
    }

    fun getCheckValue(@NonNull call: MethodCall, @NonNull resule: Result) {
        val keyTypt = call.argument<Int>("key_type")
        val keyId = call.argument<Int>("key_id")
        resule.success(
            HexUtils.bcd2str(
                device?.pinpadDevice?.getCheckValue(
                    KeyType.values()[keyTypt!!],
                    keyId!!
                )
            )
        )
    }

    fun checkCard(@NonNull call: MethodCall, @NonNull result: Result) {
        val handler = Handler()
        device?.emvKernelDevice?.checkCard(true, true, true, 20000, object : OnCheckCardResult {
            override fun onFindMagCard(p0: CommonTrackData?) {
                val trackData = TrackData()
                trackData.cardno = HexUtils.bcd2str(p0?.cardNo)
                trackData.firstTrackData = HexUtils.bcd2str(p0?.track1)
                trackData.secondTrackData = HexUtils.bcd2str(p0?.track2)
                trackData.thirdTrackData = HexUtils.bcd2str(p0?.track3)
                trackData.expiryDate = HexUtils.bcd2str(p0?.expire)
                val event = CheckCardEvent()
                event.name = "onFindMagCard"
                event.trackData = trackData
                handler.post { methodChannel.invokeMethod("CheckCardEvent", gson?.toJson(event)) }
            }

            override fun onFindICCard() {
                val event = CheckCardEvent()
                event.name = "onFindICCard"
                handler.post { methodChannel.invokeMethod("CheckCardEvent", gson?.toJson(event)) }
            }

            override fun onFindRFCard() {
                val event = CheckCardEvent()
                event.name = "onFindRFCard"
                handler.post { methodChannel.invokeMethod("CheckCardEvent", gson?.toJson(event)) }
            }

            override fun onError(p0: Int, p1: String?) {
                val event = CheckCardEvent()
                event.name = "onError"
                event.errorCode = p0
                event.errorMsg = p1
                handler.post { methodChannel.invokeMethod("CheckCardEvent", gson?.toJson(event)) }
            }
        })
        result.success(null)
    }

    fun stopCheckCard(@NonNull call: MethodCall, @NonNull result: Result) {
        device?.emvKernelDevice?.stopCheckCard()
        result.success(null)
    }

    fun processEmv(@NonNull call: MethodCall, @NonNull result: Result) {
        val handler = Handler()
        val emvFlow = call.argument<Int>("emv_flow")
        val forceOnline = call.argument<Boolean>("force_online")
        val tvlBytes = call.argument<ByteArray>("tlv_bytes")
        device?.emvKernelDevice?.processEmv(
            EmvTransType.SALE_GOODS,
            createEmvTransParams(
                EmvTransParam.EmvFlow.values()[emvFlow!!],
                forceOnline!!,
                tvlBytes!!
            ),
            object : IEmvKernelListener.Stub() {
                override fun onRequestAmount(p0: Int) {
                    val emvProcessEvent = EmvProcessEvent()
                    emvProcessEvent.name = "onRequestAmount"
                    emvProcessEvent.amount = p0.toString()
                    handler.post {
                        methodChannel.invokeMethod(
                            "EmvProcessEvent",
                            gson?.toJson(emvProcessEvent)
                        )
                    }
                }

                override fun onRequestAccount() {
                    val emvProcessEvent = EmvProcessEvent()
                    emvProcessEvent.name = "onRequestAccount"
                    handler.post {
                        methodChannel.invokeMethod(
                            "EmvProcessEvent",
                            gson?.toJson(emvProcessEvent)
                        )
                    }
                }

                override fun onRequestTipsConfirm(title: ByteArray?, content: ByteArray?) {
                    val emvProcessEvent = EmvProcessEvent()
                    emvProcessEvent.name = "onRequestTipsConfirm"
                    emvProcessEvent.tipTitle = HexUtils.bcd2str(title)
                    emvProcessEvent.tipContent = HexUtils.bcd2str(content)
                    handler.post {
                        methodChannel.invokeMethod(
                            "EmvProcessEvent",
                            gson?.toJson(emvProcessEvent)
                        )
                    }
                }

                override fun onRequestAidSelect(p0: Int, aids: Array<out String>?) {
                    val emvProcessEvent = EmvProcessEvent()
                    emvProcessEvent.name = "onRequestAidSelect"
                    emvProcessEvent.aids = aids?.asList()
                    handler.post {
                        methodChannel.invokeMethod(
                            "EmvProcessEvent",
                            gson?.toJson(emvProcessEvent)
                        )
                    }
                }

                override fun onRequestEcashTipsConfirm() {
                    val emvProcessEvent = EmvProcessEvent()
                    emvProcessEvent.name = "onRequestEcashTipsConfirm"
                    handler.post {
                        methodChannel.invokeMethod(
                            "EmvProcessEvent",
                            gson?.toJson(emvProcessEvent)
                        )
                    }
                }

                override fun onConfirmCardInfo(cardNo: String?) {
                    val emvProcessEvent = EmvProcessEvent()
                    emvProcessEvent.name = "onConfirmCardInfo"
                    emvProcessEvent.cardNo = cardNo
                    handler.post {
                        methodChannel.invokeMethod(
                            "EmvProcessEvent",
                            gson?.toJson(emvProcessEvent)
                        )
                    }
                }

                override fun onRequestPin(isOnlinePin: Boolean, amount: String?) {
                    val emvProcessEvent = EmvProcessEvent()
                    emvProcessEvent.name = "onRequestPin"
                    emvProcessEvent.isOnlinePin = isOnlinePin
                    emvProcessEvent.amount = amount
                    handler.post {
                        methodChannel.invokeMethod(
                            "EmvProcessEvent",
                            gson?.toJson(emvProcessEvent)
                        )
                    }
                }

                override fun onRequestUserAuth(type: Int, content: ByteArray?) {
                    val emvProcessEvent = EmvProcessEvent()
                    emvProcessEvent.name = "onRequestUserAuth"
                    emvProcessEvent.type = type
                    emvProcessEvent.authContent = HexUtils.bcd2str(content)
                    handler.post {
                        methodChannel.invokeMethod(
                            "EmvProcessEvent",
                            gson?.toJson(emvProcessEvent)
                        )
                    }
                }

                override fun onRequestVoiceTipConfirm() {
                    val emvProcessEvent = EmvProcessEvent()
                    emvProcessEvent.name = "onRequestVoiceTipConfirm"
                    handler.post {
                        methodChannel.invokeMethod(
                            "EmvProcessEvent",
                            gson?.toJson(emvProcessEvent)
                        )
                    }
                }

                override fun onConfirmFinalSelect(aid: ByteArray?) {
                    val emvProcessEvent = EmvProcessEvent()
                    emvProcessEvent.name = "onConfirmFinalSelect"
                    emvProcessEvent.finalAid = HexUtils.bcd2str(aid)
                    handler.post {
                        methodChannel.invokeMethod(
                            "EmvProcessEvent",
                            gson?.toJson(emvProcessEvent)
                        )
                    }
                }

                override fun onSignatureRequest() {
                    val emvProcessEvent = EmvProcessEvent()
                    emvProcessEvent.name = "onSignatureRequest"
                    handler.post {
                        methodChannel.invokeMethod(
                            "EmvProcessEvent",
                            gson?.toJson(emvProcessEvent)
                        )
                    }
                }

                override fun onCvmFlagVerify() {
                    val emvProcessEvent = EmvProcessEvent()
                    emvProcessEvent.name = "onCvmFlagVerify"
                    handler.post {
                        methodChannel.invokeMethod(
                            "EmvProcessEvent",
                            gson?.toJson(emvProcessEvent)
                        )
                    }
                }

                override fun onRequestOnline() {
                    val emvProcessEvent = EmvProcessEvent()
                    emvProcessEvent.name = "onRequestOnline"
                    handler.post {
                        methodChannel.invokeMethod(
                            "EmvProcessEvent",
                            gson?.toJson(emvProcessEvent)
                        )
                    }
                }

                override fun onTransResult(result: Byte, message: String?) {
                    val emvProcessEvent = EmvProcessEvent()
                    emvProcessEvent.name = "onTransResult"
                    emvProcessEvent.transResult = result
                    emvProcessEvent.resultContent = message
                    handler.post {
                        methodChannel.invokeMethod(
                            "EmvProcessEvent",
                            gson?.toJson(emvProcessEvent)
                        )
                    }
                }

                override fun onError(p0: Int, p1: String?) {
                    val emvProcessEvent = EmvProcessEvent()
                    emvProcessEvent.name = "onError"
                    emvProcessEvent.errorId = p0
                    emvProcessEvent.errorMsg = p1
                    handler.post {
                        methodChannel.invokeMethod(
                            "EmvProcessEvent",
                            gson?.toJson(emvProcessEvent)
                        )
                    }
                }
            })
        result.success(null)
    }

    private fun createEmvTransParams(
        emvFlow: EmvTransParam.EmvFlow,
        forceOnline: Boolean,
        tvlBytes: ByteArray
    ): EmvTransParam? {
        return EmvTransParam.Builder()
            .setEmvFlow(emvFlow)
            .setForceOnline(forceOnline)
            .setProcessKernelDataTlv(tvlBytes)
            .create()
    }

    fun abortEmv(@NonNull call: MethodCall, @NonNull result: Result) {
        device?.emvKernelDevice?.abortEmv()
        result.success(null)
    }

    fun clearKernelICTransLog(@NonNull call: MethodCall, @NonNull result: Result) {
        device?.emvKernelDevice?.clearKernelICTransLog()
        result.success(null)
    }

    fun emvImportAmount(@NonNull call: MethodCall, @NonNull result: Result) {
        result.success(device?.emvKernelDevice?.importAmount(call.argument<String>("amount")))
    }

    fun emvImportAccountType(@NonNull call: MethodCall, @NonNull result: Result) {
        val type = call.argument<Int>("type")
        result.success(type?.let { device?.emvKernelDevice?.importAccountType(it) })
    }

    fun emvImportAidSelectRes(@NonNull call: MethodCall, @NonNull result: Result) {
        val index = call.argument<Int>("index")
        result.success(index?.let { device?.emvKernelDevice?.importAidSelectRes(it) })
    }

    fun emvImportIssuerVoiceReference(@NonNull call: MethodCall, @NonNull result: Result) {
        val res = call.argument<Byte>("res")
        result.success(res?.let { device?.emvKernelDevice?.importIssuerVoiceReference(it) })
    }

    fun emvImportConfirmCardInfoRes(@NonNull call: MethodCall, @NonNull result: Result) {
        val res = call.argument<Boolean>("res")
        result.success(res?.let { device?.emvKernelDevice?.importConfirmCardInfoRes(it) })
    }

    fun emvImportPin(@NonNull call: MethodCall, @NonNull result: Result) {
        val isOnlinePin = call.argument<Boolean>("isOnlinePin")
        val pin = call.argument<String>("pin")
        result.success(
            device?.emvKernelDevice?.importPin(
                isOnlinePin!!,
                HexUtils.hexStringToByte(pin)
            )
        )
    }

    fun emvImportUserAuthRes(@NonNull call: MethodCall, @NonNull result: Result) {
        val res = call.argument<Boolean>("res")
        result.success(device?.emvKernelDevice?.importUserAuthRes(res!!))
    }

    fun emvImportMsgConfirmRes(@NonNull call: MethodCall, @NonNull result: Result) {
        val res = call.argument<Boolean>("res")
        result.success(device?.emvKernelDevice?.importMsgConfirmRes(res!!))
    }

    fun emvImportECashTipConfirmRes(@NonNull call: MethodCall, @NonNull result: Result) {
        val res = call.argument<Boolean>("res")
        result.success(device?.emvKernelDevice?.importECashTipConfirmRes(res!!))
    }

    fun emvImportOnlineResp(@NonNull call: MethodCall, @NonNull result: Result) {
        val onlineRes = call.argument<Boolean>("onlineRes")
        val respCode = call.argument<String>("respCode")
        val icData55 = call.argument<String>("icData55")
        result.success(device?.emvKernelDevice?.importOnlineResp(onlineRes!!, respCode, icData55))
    }

    fun emvImportResultOfSignatureRequest(@NonNull call: MethodCall, @NonNull result: Result) {
        val res = call.argument<Boolean>("res")
        result.success(device?.emvKernelDevice?.importResultOfSignatureRequest(res!!))
    }

    fun emvImportResultOfCvmFlagVerify(@NonNull call: MethodCall, @NonNull result: Result) {
        val res = call.argument<Boolean>("res")
        result.success(device?.emvKernelDevice?.importResultOfCvmFlagVerify(res!!))
    }

    fun emvImportFinalAidConfigsSelect(@NonNull call: MethodCall, @NonNull result: Result) {
        val res = call.argument<Boolean>("res")
        val params = call.argument<String>("params")
        result.success(
            device?.emvKernelDevice?.importFinalAidConfigsSelect(
                res!!,
                HexUtils.hexStringToByte(params)
            )
        )
    }

    fun emvUpdateAID(@NonNull call: MethodCall, @NonNull result: Result) {
        val optFlag = call.argument<Int>("optFlag")
        val aid = call.argument<String>("aid")
        result.success(device?.emvKernelDevice?.updateAID(EmvParamsOption.values()[optFlag!!], aid))
    }

    fun emvUpdateCAPK(@NonNull call: MethodCall, @NonNull result: Result) {
        val optFlag = call.argument<Int>("optFlag")
        val capk = call.argument<String>("capk")
        result.success(
            device?.emvKernelDevice?.updateCAPK(
                EmvParamsOption.values()[optFlag!!],
                capk
            )
        )
    }

    fun emvReadAidParameters(@NonNull call: MethodCall, @NonNull result: Result) {
        result.success(device?.emvKernelDevice?.readAidParameters())
    }

    fun emvReadCAPublicKeyParameters(@NonNull call: MethodCall, @NonNull result: Result) {
        result.success(device?.emvKernelDevice?.readCAPublicKeyParameters())
    }

    fun emvReadEmvKernelData(@NonNull call: MethodCall, @NonNull result: Result) {
        var tagList = call.argument<List<String>>("tagLists")
        var res =
            HexUtils.bytesToHexString(device?.emvKernelDevice?.readEmvKernelData(tagList?.toTypedArray()))
        result.success(res)
    }

    fun storageWrite(@NonNull call: MethodCall, @NonNull result: Result) {
        val index = call.argument<Int>("index")
        val data = call.argument<ByteArray>("data")
        result.success(device?.persistStorageDevice?.write(index!!, data!!))
    }

    fun storageRead(@NonNull call: MethodCall, @NonNull result: Result) {
        val index = call.argument<Int>("index")
        val length = call.argument<Int>("length")
        result.success(device?.persistStorageDevice?.read(index!!, length!!))
    }

    fun turnOn(@NonNull call: MethodCall, @NonNull result: Result) {
        val colorIndex = call.argument<Int>("color")
        var color: LedColor? = null
        when (colorIndex) {
            0 -> color = LedColor.BLUE
            1 -> color = LedColor.YELLOW
            2 -> color = LedColor.GREEN
            3 -> color = LedColor.RED
        }
        result.success(device?.ledDevice?.turnOn(color))
    }

    fun turnOff(@NonNull call: MethodCall, @NonNull result: Result) {
        val colorIndex = call.argument<Int>("color")
        var color: LedColor? = null
        when (colorIndex) {
            0 -> color = LedColor.BLUE
            1 -> color = LedColor.YELLOW
            2 -> color = LedColor.GREEN
            3 -> color = LedColor.RED
        }
        result.success(device?.ledDevice?.turnOff(color))
    }

    fun open(@NonNull call: MethodCall, @NonNull result: Result) {
        val boardRate = call.argument<Int>("boardRate")

        val dataBits = call.argument<Int>("TAG_DATA_BITS")?.let { HexUtils.int2bytes(it) }?.get(0)
        val checkBits = call.argument<Int>("TAG_CHECK_BITS")?.let { HexUtils.int2bytes(it) }?.get(0)
        val b = Bundle()
        b.putByte(SerialPortParameter.TAG_DATA_BITS, dataBits!!)
        b.putByte(SerialPortParameter.TAG_CHECK_BITS, checkBits!!)

        result.success(device?.serialPortDevice?.open(boardRate!!, b!!))
    }

    fun close(@NonNull call: MethodCall, @NonNull result: Result) {
        result.success(device?.serialPortDevice?.close())
    }

    fun sendData(@NonNull call: MethodCall, @NonNull result: Result) {
        val byteArray = call.argument<ByteArray>("data")
        result.success(device?.serialPortDevice?.sendData(byteArray!!))
    }

    fun receiveData(@NonNull call: MethodCall, @NonNull result: Result) {
        val timeout = call.argument<Int>("timeout")
        var byteArray = call.argument<ByteArray>("data")
        result.success(device?.serialPortDevice?.receiveData(byteArray!!, timeout!!))
    }

    fun clearCache(@NonNull call: MethodCall, @NonNull result: Result) {
        result.success(device?.serialPortDevice?.clearCache())
    }

    fun psamReset(@NonNull call: MethodCall, @NonNull result: Result) {
        val psamIndex = call.argument<Int>("psam_device")
        result.success(device?.getPsamDevice(psamIndex!!)?.reset())
    }

    fun psamSendApdu(@NonNull call: MethodCall, @NonNull result: Result) {
        val psamIndex = call.argument<Int>("psam_device")
        val apdu = call.argument<ByteArray>("apdu")
        result.success(device?.getPsamDevice(psamIndex!!)?.sendApdu(apdu))
    }

    fun psamSetETU(@NonNull call: MethodCall, @NonNull result: Result) {
        val psamIndex = call.argument<Int>("psam_device")
        val etu = call.argument<Int>("etu")?.let { HexUtils.int2bytes(it) }?.get(0)
        result.success(device?.getPsamDevice(psamIndex!!)?.setETU(etu!!))
    }

    fun psamSetCLK(@NonNull call: MethodCall, @NonNull result: Result) {
        val psamIndex = call.argument<Int>("psam_device")
        val clk = call.argument<Int>("clk")?.let { HexUtils.int2bytes(it) }?.get(0)
        result.success(device?.getPsamDevice(psamIndex!!)?.setCLK(clk!!))
    }

    fun mifareAurh(@NonNull call: MethodCall, @NonNull result: Result) {
        val type = call.argument<Int>("type")
        val blockAddr = call.argument<Int>("blockaddr")?.toByte()
        val keyData = call.argument<ByteArray>("keydata")
        val resetRes = call.argument<ByteArray>("resetRes")
        result.success(device?.mifareDevice?.auth(type!!, blockAddr!!, keyData!!, resetRes!!))
    }

    fun mifareReadBlock(@NonNull call: MethodCall, @NonNull result: Result) {
        val blockAddr = call.argument<Int>("blockaddr")?.toByte()
        val data = call.argument<ByteArray>("data")
        result.success(device?.mifareDevice?.readBlock(blockAddr!!, data!!))
    }

    fun mifareWriteBlock(@NonNull call: MethodCall, @NonNull result: Result) {
        val blockAddr = call.argument<Int>("blockaddr")?.toByte()
        val data = call.argument<ByteArray>("data")
        result.success(device?.mifareDevice?.writeBlock(blockAddr!!, data!!))
    }

    fun mifareReset(@NonNull call: MethodCall, @NonNull result: Result) {
        result.success(device?.mifareDevice?.reset())
    }

    fun mifareExists(@NonNull call: MethodCall, @NonNull result: Result) {
        result.success(device?.mifareDevice?.exists())
    }

    fun mifareReadM1Storage(@NonNull call: MethodCall, @NonNull result: Result) {
        val blockAddr = call.argument<Int>("blockaddr")?.toByte()
        result.success(device?.mifareDevice?.readM1Storage(blockAddr!!))
    }

    fun mifareWriteM1Storage(@NonNull call: MethodCall, @NonNull result: Result) {
        val blockAddr = call.argument<Int>("blockaddr")?.toByte()
        val data = call.argument<Int>("data")?.toByte()
        result.success(device?.mifareDevice?.writeM1Storage(blockAddr!!, data!!))
    }

    fun mifareMakeValue(@NonNull call: MethodCall, @NonNull result: Result) {
        val blockAddr = call.argument<Int>("blockaddr")?.toByte()
        val data = call.argument<ByteArray>("data")
        result.success(device?.mifareDevice?.makeValue(blockAddr!!, data!!))
    }

    fun mifareAddValuePure(@NonNull call: MethodCall, @NonNull result: Result) {
        val blockAddr = call.argument<Int>("blockaddr")?.toByte()
        val data = call.argument<ByteArray>("data")
        result.success(device?.mifareDevice?.addValuePure(blockAddr!!, data!!))
    }

    fun mifareReduceValuePure(@NonNull call: MethodCall, @NonNull result: Result) {
        val blockAddr = call.argument<Int>("blockaddr")?.toByte()
        val data = call.argument<ByteArray>("data")
        result.success(device?.mifareDevice?.reduceValuePure(blockAddr!!, data!!))
    }

    fun dockConnect(@NonNull call: MethodCall, @NonNull result: Result) {
        val baudRate = call.argument<Int>("baudRate")
        val type = call.argument<DockConnectType>("type")
        result.success(device?.dockDevice?.connect(type!!, baudRate!!, null))
    }

    fun dockerWrite(@NonNull call: MethodCall, @NonNull result: Result) {
        val data = call.argument<ByteArray>("data")
        result.success(device?.dockDevice?.write(data!!))
    }

    fun dockerRead(@NonNull call: MethodCall, @NonNull result: Result) {
        val buffer = call.argument<ByteArray>("buffer")
        val timeout = call.argument<Int>("timeout")
        result.success(device?.dockDevice?.read(buffer!!, timeout!!))
    }

    fun dockerClearCache(@NonNull call: MethodCall, @NonNull result: Result) {
        result.success(device?.dockDevice?.clearCache())
    }

    fun dockerDisconnect(@NonNull call: MethodCall, @NonNull result: Result) {
        result.success(device?.dockDevice?.disconnect())
    }


}
