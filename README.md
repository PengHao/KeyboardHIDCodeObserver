# EscapeKeyListener

#### Example :<br>

```
KeyboardEventManager *manager = [KeyboardEventManager sharedKeyboardEventManager];
[manager addObserver:ESC_CODE block:^(BOOL isDown) {
	//on handle ESC_CODE
	//when press down isDown=true, otherwise false
	
}];
```

#### English
EscapeKeyListener is used to listen Bluetooth Keyboard's all key event. Such as escape, command, option... <br>
All the key code is HID device code. [http://www.freebsddiary.org/APC/usb_hid_usages.php]()

#### 中文 :
EscapeKeyListener 可以用来监听实体键盘的所有按键事件。包括Esc、command、option等等<br>
所有的按键编码都是HID code。可以参照这个网页[https://wenku.baidu.com/view/03984008de80d4d8d15a4fd6.html]()


#### 日本語 :
EscapeKeyListenerはブルーツゥース　キーボードの全てのキーイベントを監視する事ができる。ESC、Command、Optionなともサポートする。<br>
全てのキーコードはHIDコードに参考する[http://www.freebsddiary.org/APC/usb_hid_usages.php]()

