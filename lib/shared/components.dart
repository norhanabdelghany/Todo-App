import 'package:flutter/material.dart';
import 'package:todo/shared/colors.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final BorderRadiusGeometry raduis;
  final VoidCallback onPressed;
  final String text;
  final Color textColor;

  CustomButton({
    this.color = Colors.white,
    this.height = 0,
    this.width = 0,
    required this.onPressed,
    this.raduis = BorderRadius.zero,
    this.text = "",
    this.textColor = Colors.black,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: MaterialButton(
        color: color,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 20,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: raduis,
        ),
        onPressed: onPressed,
      ),
    );
  }
}

void navigateTo(context, Widget widget) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => widget),
  );
}

void navigateAndFinish(context, Widget widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget),
    (Route<dynamic> route) => false,
  );
}

class TaskItem extends StatelessWidget {
  final String taskTitle;
  final bool active;
  final VoidCallback onView;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final Function onChange;
  TaskItem({
    required this.active,
    required this.onChange,
    required this.onDelete,
    required this.onEdit,
    required this.taskTitle,
    required this.onView,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    bool value = false;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      alignment: Alignment.center,
      height: height * 0.07,
      width: width * 0.8,
      child: Row(
        children: [

          Checkbox(
            activeColor: Colors.green,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            value: active,

            onChanged: (bool? value) {
              return onChange(value);
            },
          ),
          Text(
            taskTitle,
            style: TextStyle(color: kPrimaryBlue, fontSize: 20),
          ),
          Spacer(),
          IconButton(
            onPressed: onView,
            icon: Icon(Icons.visibility_outlined),
            color: kButtonBlue,
          ),
          IconButton(
            onPressed: onEdit,
            icon: Icon(Icons.edit),
            color: kButtonBlue,
          ),
          IconButton(
            onPressed: onDelete,
            icon: Icon(Icons.delete),
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}

class CustomItem extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  final String hintText;
  final BorderRadius borderRadius;
  final bool isSecure;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? InputTextStyle;
  final Function? validate;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color borderColor;
  final Color backgroundColor;
  final bool isFilled;
  final int? maxLines;
  final bool isEnabled;
  final EdgeInsetsGeometry? contentPadding;
  CustomItem({
    this.labelText = '',
    this.backgroundColor = Colors.blue,
    this.borderColor = Colors.transparent,
    this.borderRadius = BorderRadius.zero,
    this.controller,
    this.hintStyle,
    this.hintText = '',
    this.isFilled = true,
    this.isSecure = false,
    this.labelStyle,
    this.prefixIcon,
    this.suffixIcon,
    this.validate,
    this.maxLines,
    this.isEnabled = true,
    this.contentPadding,
    this.InputTextStyle,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: labelStyle,
        ),
        TextFormField(
          validator: (String? val) {
            return validate!(val);
          },
          enabled: isEnabled,
          maxLines: maxLines,
          controller: controller,
          obscureText: isSecure,
          style: InputTextStyle,
          decoration: InputDecoration(
            contentPadding: contentPadding,
            border: OutlineInputBorder(borderRadius: borderRadius),
            hintText: hintText,
            hintStyle: hintStyle,
            prefixIcon: prefixIcon,
            enabledBorder: OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: BorderSide(
                  width: 1,
                  color: borderColor,
                )),
            errorBorder: OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: BorderSide(
                  width: 1,
                  color: borderColor,
                )),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: BorderSide(
                  width: 1,
                  color: borderColor,
                )),
            disabledBorder: OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: BorderSide(
                  width: 1,
                  color: borderColor,
                )),
            fillColor: backgroundColor,
            filled: isFilled,
            focusedBorder: OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: BorderSide(
                  width: 1,
                  color: borderColor,
                )),
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}
