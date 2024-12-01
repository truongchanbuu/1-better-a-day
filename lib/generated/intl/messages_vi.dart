// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a vi locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'vi';

  static String m0(completedTasks, totalTasks) =>
      "${completedTasks}/${totalTasks}";

  static String m1(count) =>
      "${Intl.plural(count, zero: '0 thói quen', one: '1 thói quen', other: '${count} thói quen')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "accept_button": MessageLookupByLibrary.simpleMessage("Chấp nhận"),
        "account_exists_with_different_credential":
            MessageLookupByLibrary.simpleMessage(
                "Tài khoản đã tồn tại với thông tin đăng nhập khác."),
        "account_section": MessageLookupByLibrary.simpleMessage("Tài khoản"),
        "achievement_done": MessageLookupByLibrary.simpleMessage("Thành tựu"),
        "afternoon_tile": MessageLookupByLibrary.simpleMessage("Buổi chiều"),
        "age_field": MessageLookupByLibrary.simpleMessage("Tuổi"),
        "all_habits": MessageLookupByLibrary.simpleMessage("Tất cả thói quen"),
        "app_info_section":
            MessageLookupByLibrary.simpleMessage("Thông tin bổ sung"),
        "authentication_choice":
            MessageLookupByLibrary.simpleMessage("Đăng nhập/Đăng ký"),
        "birth_date": MessageLookupByLibrary.simpleMessage("Sinh nhật"),
        "cancel_button": MessageLookupByLibrary.simpleMessage("Hủy bỏ"),
        "confirm_password_field":
            MessageLookupByLibrary.simpleMessage("Xác nhận mật khẩu"),
        "current_streak": MessageLookupByLibrary.simpleMessage("Chuỗi"),
        "dark_theme": MessageLookupByLibrary.simpleMessage("Chế độ tối"),
        "dawn_tile": MessageLookupByLibrary.simpleMessage("Bình minh"),
        "display_name": MessageLookupByLibrary.simpleMessage("Tên"),
        "done_tasks": m0,
        "dusk_tile": MessageLookupByLibrary.simpleMessage("Hoàng hôn"),
        "email_already_in_use": MessageLookupByLibrary.simpleMessage(
            "Đã có tài khoản sử dụng email này."),
        "empty_field": MessageLookupByLibrary.simpleMessage(
            "Vui lòng không để trống trường này"),
        "english_choice": MessageLookupByLibrary.simpleMessage("Tiếng Anh"),
        "failure_title": MessageLookupByLibrary.simpleMessage("Thất bại"),
        "gender_field": MessageLookupByLibrary.simpleMessage("Giới tính"),
        "general_section": MessageLookupByLibrary.simpleMessage("Chung"),
        "habits": m1,
        "help_tile": MessageLookupByLibrary.simpleMessage("Trợ giúp"),
        "imperial_unit": MessageLookupByLibrary.simpleMessage("Hệ Anh"),
        "invalid_age": MessageLookupByLibrary.simpleMessage(
            "Vui lòng chọn một độ tuổi phù hợp"),
        "invalid_credential": MessageLookupByLibrary.simpleMessage(
            "Email hoặc mật khẩu không hợp lệ."),
        "invalid_email": MessageLookupByLibrary.simpleMessage(
            "Email không hợp lệ hoặc được định dạng sai."),
        "invalid_form": MessageLookupByLibrary.simpleMessage(
            "Vui lòng kiểm tra lại thông tin của bạn"),
        "invalid_password": MessageLookupByLibrary.simpleMessage(
            "Mật khẩu phải có ít nhất 6 ký tự"),
        "invalid_phone":
            MessageLookupByLibrary.simpleMessage("Số điện thoại không hợp lệ"),
        "invalid_verification_code": MessageLookupByLibrary.simpleMessage(
            "Mã xác minh nhận được không hợp lệ."),
        "invalid_verification_id": MessageLookupByLibrary.simpleMessage(
            "ID xác minh nhận được không hợp lệ."),
        "language_tile": MessageLookupByLibrary.simpleMessage("Ngôn ngữ"),
        "light_theme": MessageLookupByLibrary.simpleMessage("Chế độ sáng"),
        "loading_title": MessageLookupByLibrary.simpleMessage("Đang tải..."),
        "login_failure_title":
            MessageLookupByLibrary.simpleMessage("Đăng nhập thất bại"),
        "login_success_title":
            MessageLookupByLibrary.simpleMessage("Đăng nhập thành công"),
        "logout_button": MessageLookupByLibrary.simpleMessage("Đăng xuất"),
        "manage_account_choice":
            MessageLookupByLibrary.simpleMessage("Quản lý tài khoản"),
        "measurement_unit_title":
            MessageLookupByLibrary.simpleMessage("Đơn vị đo lường"),
        "metric_unit": MessageLookupByLibrary.simpleMessage("Hệ mét"),
        "no_date_selected":
            MessageLookupByLibrary.simpleMessage("Chưa ngày nào được chọn"),
        "notifications": MessageLookupByLibrary.simpleMessage("Thông báo"),
        "operation_not_allowed": MessageLookupByLibrary.simpleMessage(
            "Hoạt động không được phép. Vui lòng liên hệ hỗ trợ."),
        "password_field": MessageLookupByLibrary.simpleMessage("Mật khẩu"),
        "passwords_do_not_match":
            MessageLookupByLibrary.simpleMessage("Mật khẩu không trùng khớp"),
        "personal_info_section":
            MessageLookupByLibrary.simpleMessage("Thông tin cá nhân"),
        "phone_number": MessageLookupByLibrary.simpleMessage("Điện thoại"),
        "re_auth_with_email":
            MessageLookupByLibrary.simpleMessage("Xác thực với Email"),
        "re_auth_with_google":
            MessageLookupByLibrary.simpleMessage("Xác thực với Google"),
        "recovery_description": MessageLookupByLibrary.simpleMessage(
            "Một email đặt lại mật khẩu sẽ được gửi tới email của bạn"),
        "reset_password":
            MessageLookupByLibrary.simpleMessage("Đặt lại mật khẩu"),
        "send_button": MessageLookupByLibrary.simpleMessage("Gửi"),
        "settings": MessageLookupByLibrary.simpleMessage("Cài đặt"),
        "statistic_section": MessageLookupByLibrary.simpleMessage("Thống kê"),
        "success_title": MessageLookupByLibrary.simpleMessage("Thành công"),
        "term_and_condition_statement": MessageLookupByLibrary.simpleMessage(
            "Bằng cách đăng nhập/đăng ký, bạn chấp nhận Điều khoản và Điều kiện của chúng tôi và đồng ý với Chính sách Quyền riêng tư"),
        "terms_and_conditions":
            MessageLookupByLibrary.simpleMessage("Điều khoản & Điều kiện"),
        "theme_tile": MessageLookupByLibrary.simpleMessage("Giao diện"),
        "time_of_day_section":
            MessageLookupByLibrary.simpleMessage("Thời gian trong ngày"),
        "today_tasks": MessageLookupByLibrary.simpleMessage("Nhiệm vụ hôm nay"),
        "try_again":
            MessageLookupByLibrary.simpleMessage("Vui lòng thử lại sau"),
        "unknown_exception": MessageLookupByLibrary.simpleMessage(
            "Đã xảy ra lỗi không xác định."),
        "update_failure_title":
            MessageLookupByLibrary.simpleMessage("Cập nhật thất bại"),
        "update_success_title":
            MessageLookupByLibrary.simpleMessage("Cập nhật thành công"),
        "user_disabled": MessageLookupByLibrary.simpleMessage(
            "Người dùng này đã bị vô hiệu hóa. Vui lòng liên hệ hỗ trợ để được giúp đỡ."),
        "user_not_found": MessageLookupByLibrary.simpleMessage(
            "Email không được tìm thấy, vui lòng tạo tài khoản."),
        "verify_email_sent": MessageLookupByLibrary.simpleMessage(
            "Một mail vừa được gửi vào email mới của bạn"),
        "vietnamese_choice": MessageLookupByLibrary.simpleMessage("Tiếng Việt"),
        "warning_title": MessageLookupByLibrary.simpleMessage("Cảnh báo"),
        "weak_password": MessageLookupByLibrary.simpleMessage(
            "Vui lòng nhập mật khẩu mạnh hơn."),
        "wrong_password": MessageLookupByLibrary.simpleMessage(
            "Mật khẩu không chính xác, vui lòng thử lại.")
      };
}
