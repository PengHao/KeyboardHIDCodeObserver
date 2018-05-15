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
All the key code is HID device code. [http://www.freebsddiary.org/APC/usb_hid_usages.php](http://www.freebsddiary.org/APC/usb_hid_usages.php)
