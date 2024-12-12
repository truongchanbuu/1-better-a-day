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

  static String m0(count) =>
      "${Intl.plural(count, zero: 'Đạt đuược: 0', one: 'Đạt được: 1', other: 'Đạt được: ${count}')}";

  static String m1(selection, percentageValue) => "${Intl.select(selection, {
            'positive': '+${percentageValue}% so với tuần trước',
            'negative': '-${percentageValue}% so với tuần trước',
            'neutral': 'Không thay đổi kể từ tuần trước',
            'other': 'Không thay đổi kể từ tuần trước',
          })}";

  static String m2(completedTasks, totalTasks) =>
      "${completedTasks}/${totalTasks}";

  static String m3(count) =>
      "${Intl.plural(count, zero: 'Thất bại: 0', one: 'Thất bại: 1', other: 'Thất bại: ${count}')}";

  static String m4(count) =>
      "${Intl.plural(count, zero: '0 thói quen', one: '1 thói quen', other: '${count} thói quen')}";

  static String m5(count) =>
      "${Intl.plural(count, zero: 'Đang tiến hành: 0', one: 'Đang tiến hành: 1', other: 'Đang tiến hành: ${count}')}";

  static String m6(count) =>
      "${Intl.plural(count, zero: 'Hôm nay', one: '1 ngày qua', other: '${count} ngày qua')}";

  static String m7(value) => "Bạn đã đi được ${value}% chặng đường";

  static String m8(count, total, time) => "Tiến độ: ${count}/${total} ${time}";

  static String m9(count) =>
      "${Intl.plural(count, zero: 'Tạm dừng: 0', one: 'Tạm dừng: 1', other: 'Tạm dừng: ${count}')}";

  static String m10(count) => "Tổng số: ${count}";

  static String m11(count) =>
      "${Intl.plural(count, zero: 'Chưa có thành tựu nào', one: '1 thành tựu', other: '${count} thành tựu')}";

  static String m12(count) =>
      "${Intl.plural(count, zero: 'Chưa thực hiện chuỗi', one: 'Chuỗi 1', other: 'Chuối ${count} ngày')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "accept_button": MessageLookupByLibrary.simpleMessage("Chấp nhận"),
        "account_exists_with_different_credential":
            MessageLookupByLibrary.simpleMessage(
                "Tài khoản đã tồn tại với thông tin đăng nhập khác."),
        "account_section": MessageLookupByLibrary.simpleMessage("Tài khoản"),
        "achieved": m0,
        "achieved_habit":
            MessageLookupByLibrary.simpleMessage("Các thói quen đã đạt được"),
        "achieved_statistic_page":
            MessageLookupByLibrary.simpleMessage("Đã đạt được"),
        "achievement_done": MessageLookupByLibrary.simpleMessage("Thành tựu"),
        "active_button": MessageLookupByLibrary.simpleMessage("Kích hoạt"),
        "active_habit": MessageLookupByLibrary.simpleMessage(
            "Các thói quen đang thực hiện"),
        "active_statistic_page":
            MessageLookupByLibrary.simpleMessage("Đang thực hiện"),
        "add_habit": MessageLookupByLibrary.simpleMessage("Add Habit"),
        "add_water_button": MessageLookupByLibrary.simpleMessage("Thêm 250ML"),
        "afternoon_tile": MessageLookupByLibrary.simpleMessage("Buổi chiều"),
        "age_field": MessageLookupByLibrary.simpleMessage("Tuổi"),
        "all_detail_history":
            MessageLookupByLibrary.simpleMessage("Chi tiết các lịch sử"),
        "all_habits": MessageLookupByLibrary.simpleMessage("Tất cả thói quen"),
        "all_statistic_page": MessageLookupByLibrary.simpleMessage("Tất cả"),
        "app_info_section":
            MessageLookupByLibrary.simpleMessage("Thông tin bổ sung"),
        "authentication_choice":
            MessageLookupByLibrary.simpleMessage("Đăng nhập/Đăng ký"),
        "avg_time":
            MessageLookupByLibrary.simpleMessage("Thời gian trung bình"),
        "best_time":
            MessageLookupByLibrary.simpleMessage("Khoảng thời gian tốt nhất"),
        "birth_date": MessageLookupByLibrary.simpleMessage("Sinh nhật"),
        "cancel_button": MessageLookupByLibrary.simpleMessage("Hủy bỏ"),
        "category_based_completion_rate": MessageLookupByLibrary.simpleMessage(
            "Tỉ lệ hoàn thành theo danh mục"),
        "category_distribution":
            MessageLookupByLibrary.simpleMessage("Phân bố theo danh mục"),
        "change_from_last_week": m1,
        "completion_rate":
            MessageLookupByLibrary.simpleMessage("Tỉ lệ hoàn thành"),
        "confirm_password_field":
            MessageLookupByLibrary.simpleMessage("Xác nhận mật khẩu"),
        "current_distance":
            MessageLookupByLibrary.simpleMessage("Quãng đường hiện tại"),
        "current_progress":
            MessageLookupByLibrary.simpleMessage("Tiến độ hiện tại"),
        "dark_theme": MessageLookupByLibrary.simpleMessage("Chế độ tối"),
        "date_title": MessageLookupByLibrary.simpleMessage("Ngày"),
        "dawn_tile": MessageLookupByLibrary.simpleMessage("Bình minh"),
        "day_title": MessageLookupByLibrary.simpleMessage("Ngày"),
        "delete_button": MessageLookupByLibrary.simpleMessage("Xóa"),
        "detail_section": MessageLookupByLibrary.simpleMessage("Chi tiết"),
        "display_name": MessageLookupByLibrary.simpleMessage("Tên"),
        "done_tasks": m2,
        "duration_title":
            MessageLookupByLibrary.simpleMessage("Thời gian thực hiện"),
        "dusk_tile": MessageLookupByLibrary.simpleMessage("Hoàng hôn"),
        "edit_button": MessageLookupByLibrary.simpleMessage("Chỉnh sửa"),
        "email_already_in_use": MessageLookupByLibrary.simpleMessage(
            "Đã có tài khoản sử dụng email này."),
        "empty_field": MessageLookupByLibrary.simpleMessage(
            "Vui lòng không để trống trường này"),
        "end_date": MessageLookupByLibrary.simpleMessage("Ngày kết thúc"),
        "english_choice": MessageLookupByLibrary.simpleMessage("Tiếng Anh"),
        "failed": m3,
        "failed_habit":
            MessageLookupByLibrary.simpleMessage("Các thói quen đã thất bại"),
        "failed_rate": MessageLookupByLibrary.simpleMessage("Tỉ lệ thất bại"),
        "failed_statistic_page":
            MessageLookupByLibrary.simpleMessage("Thất bại"),
        "failure_title": MessageLookupByLibrary.simpleMessage("Thất bại"),
        "find_button": MessageLookupByLibrary.simpleMessage("Tìm kiếm"),
        "gender_field": MessageLookupByLibrary.simpleMessage("Giới tính"),
        "general_section": MessageLookupByLibrary.simpleMessage("Chung"),
        "habit_category_creativity":
            MessageLookupByLibrary.simpleMessage("Sáng tạo"),
        "habit_category_environmental":
            MessageLookupByLibrary.simpleMessage("Môi trường"),
        "habit_category_finance":
            MessageLookupByLibrary.simpleMessage("Tài chính"),
        "habit_category_health":
            MessageLookupByLibrary.simpleMessage("Sức khỏe"),
        "habit_category_learning":
            MessageLookupByLibrary.simpleMessage("Học tập"),
        "habit_category_lifestyle":
            MessageLookupByLibrary.simpleMessage("Phong cách sống"),
        "habit_category_mindfulness":
            MessageLookupByLibrary.simpleMessage("Chánh niệm"),
        "habit_category_nutrition":
            MessageLookupByLibrary.simpleMessage("Dinh dưỡng"),
        "habit_category_productivity":
            MessageLookupByLibrary.simpleMessage("Năng suất"),
        "habit_category_social": MessageLookupByLibrary.simpleMessage("Xã hội"),
        "habit_category_unknown":
            MessageLookupByLibrary.simpleMessage("Không xác định"),
        "habit_day_performance": MessageLookupByLibrary.simpleMessage(
            "Hiệu suất các ngày trong tuần"),
        "habit_detail":
            MessageLookupByLibrary.simpleMessage("Chi tiết thói quen"),
        "habit_failure_reason_external_distractions":
            MessageLookupByLibrary.simpleMessage("Phân tâm bên ngoài"),
        "habit_failure_reason_forgetfulness":
            MessageLookupByLibrary.simpleMessage("Hay quên"),
        "habit_failure_reason_health_issues":
            MessageLookupByLibrary.simpleMessage("Vấn đề sức khỏe"),
        "habit_failure_reason_lack_of_motivation":
            MessageLookupByLibrary.simpleMessage("Thiếu động lực"),
        "habit_failure_reason_lack_of_resources":
            MessageLookupByLibrary.simpleMessage("Thiếu tài nguyên"),
        "habit_failure_reason_lack_of_time":
            MessageLookupByLibrary.simpleMessage("Thiếu thời gian"),
        "habit_failure_reason_other":
            MessageLookupByLibrary.simpleMessage("Khác"),
        "habit_failure_reason_procrastination":
            MessageLookupByLibrary.simpleMessage("Trì hoãn"),
        "habit_failure_reason_too_difficult":
            MessageLookupByLibrary.simpleMessage("Quá khó khăn"),
        "habit_failure_reason_unexpected_events":
            MessageLookupByLibrary.simpleMessage("Sự kiện bất ngờ"),
        "habit_failure_reason_unknown":
            MessageLookupByLibrary.simpleMessage("Không xác định"),
        "habit_name": MessageLookupByLibrary.simpleMessage("Tên thói quen"),
        "habit_pause_reason_health_issues":
            MessageLookupByLibrary.simpleMessage("Vấn đề sức khỏe"),
        "habit_pause_reason_lack_of_motivation":
            MessageLookupByLibrary.simpleMessage("Thiếu động lực"),
        "habit_pause_reason_lack_of_time":
            MessageLookupByLibrary.simpleMessage("Thiếu thời gian"),
        "habit_pause_reason_need_for_rest":
            MessageLookupByLibrary.simpleMessage("Cần nghỉ ngơi"),
        "habit_pause_reason_other":
            MessageLookupByLibrary.simpleMessage("Khác"),
        "habit_pause_reason_reassessment":
            MessageLookupByLibrary.simpleMessage("Đánh giá lại"),
        "habit_pause_reason_unexpected_events":
            MessageLookupByLibrary.simpleMessage("Sự kiện bất ngờ"),
        "habit_pause_reason_unknown":
            MessageLookupByLibrary.simpleMessage("Không xác định"),
        "habit_status_achieved":
            MessageLookupByLibrary.simpleMessage("Đạt được"),
        "habit_status_distribution":
            MessageLookupByLibrary.simpleMessage("Phân bố theo trạng thái"),
        "habit_status_failed": MessageLookupByLibrary.simpleMessage("Thất bại"),
        "habit_status_in_progress":
            MessageLookupByLibrary.simpleMessage("Đang thực hiện"),
        "habit_status_paused": MessageLookupByLibrary.simpleMessage("Tạm dừng"),
        "habit_status_pending":
            MessageLookupByLibrary.simpleMessage("Chờ xử lý"),
        "habit_status_skipped": MessageLookupByLibrary.simpleMessage("Bỏ qua"),
        "habit_status_unknown":
            MessageLookupByLibrary.simpleMessage("Không xác định"),
        "habits": m4,
        "help_tile": MessageLookupByLibrary.simpleMessage("Trợ giúp"),
        "history_section":
            MessageLookupByLibrary.simpleMessage("Lịch sử thực hiện"),
        "imperial_unit": MessageLookupByLibrary.simpleMessage("Hệ Anh"),
        "in_progress": m5,
        "in_progress_habit": MessageLookupByLibrary.simpleMessage(
            "Các thói quen đang thực hiện"),
        "inactive_button":
            MessageLookupByLibrary.simpleMessage("Không kích hoạt"),
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
        "last_n_day": m6,
        "less_title": MessageLookupByLibrary.simpleMessage("Ít"),
        "light_theme": MessageLookupByLibrary.simpleMessage("Chế độ sáng"),
        "loading_title": MessageLookupByLibrary.simpleMessage("Đang tải..."),
        "login_failure_title":
            MessageLookupByLibrary.simpleMessage("Đăng nhập thất bại"),
        "login_success_title":
            MessageLookupByLibrary.simpleMessage("Đăng nhập thành công"),
        "logout_button": MessageLookupByLibrary.simpleMessage("Đăng xuất"),
        "longest_streak":
            MessageLookupByLibrary.simpleMessage("Chuỗi dài nhất"),
        "manage_account_choice":
            MessageLookupByLibrary.simpleMessage("Quản lý tài khoản"),
        "mark_as_done": MessageLookupByLibrary.simpleMessage("Đã thực hiện"),
        "mark_as_pause": MessageLookupByLibrary.simpleMessage("Tạm dừng"),
        "measurement_unit_title":
            MessageLookupByLibrary.simpleMessage("Đơn vị đo lường"),
        "metric_unit": MessageLookupByLibrary.simpleMessage("Hệ mét"),
        "miss_title": MessageLookupByLibrary.simpleMessage("Bỏ lỡ"),
        "month_title": MessageLookupByLibrary.simpleMessage("Tháng"),
        "monthly_process_section":
            MessageLookupByLibrary.simpleMessage("Hằng tháng"),
        "mood_distribution":
            MessageLookupByLibrary.simpleMessage("Phân bố tâm trạng"),
        "mood_title": MessageLookupByLibrary.simpleMessage("Tâm trạng"),
        "more_title": MessageLookupByLibrary.simpleMessage("Nhiều"),
        "most_mood": MessageLookupByLibrary.simpleMessage(
            "Tâm trạng xuất hiện nhiều nhất"),
        "most_reason":
            MessageLookupByLibrary.simpleMessage("Nguyên nhân chủ yếu"),
        "next_habits_button":
            MessageLookupByLibrary.simpleMessage("Trang kế tiếp"),
        "no_data_title": MessageLookupByLibrary.simpleMessage("Trống"),
        "no_date_selected":
            MessageLookupByLibrary.simpleMessage("Chưa ngày nào được chọn"),
        "not_allow_track": MessageLookupByLibrary.simpleMessage(
            "Chúng tôi không được cấp quyền để theo dõi quãng đường di chuyển của bạn"),
        "notifications": MessageLookupByLibrary.simpleMessage("Thông báo"),
        "on_your_way": m7,
        "operation_not_allowed": MessageLookupByLibrary.simpleMessage(
            "Hoạt động không được phép. Vui lòng liên hệ hỗ trợ."),
        "out_of_range": MessageLookupByLibrary.simpleMessage(
            "Số hiện tại đang vượt quá mức"),
        "overall_completion_rate":
            MessageLookupByLibrary.simpleMessage("Tổng tỉ lệ hoàn thành"),
        "overall_progress": m8,
        "password_field": MessageLookupByLibrary.simpleMessage("Mật khẩu"),
        "passwords_do_not_match":
            MessageLookupByLibrary.simpleMessage("Mật khẩu không trùng khớp"),
        "pause_statistic_page":
            MessageLookupByLibrary.simpleMessage("Tạm ngưng"),
        "pause_tracking": MessageLookupByLibrary.simpleMessage("Dừng theo dõi"),
        "paused": m9,
        "paused_habit":
            MessageLookupByLibrary.simpleMessage("Các thói quen đang tạm dừng"),
        "personal_info_section":
            MessageLookupByLibrary.simpleMessage("Thông tin cá nhân"),
        "phone_number": MessageLookupByLibrary.simpleMessage("Điện thoại"),
        "previous_habits_button":
            MessageLookupByLibrary.simpleMessage("Trang trước đó"),
        "progress_section": MessageLookupByLibrary.simpleMessage("Quá trình"),
        "re_auth_with_email":
            MessageLookupByLibrary.simpleMessage("Xác thực với Email"),
        "re_auth_with_google":
            MessageLookupByLibrary.simpleMessage("Xác thực với Google"),
        "recovery_description": MessageLookupByLibrary.simpleMessage(
            "Một email đặt lại mật khẩu sẽ được gửi tới email của bạn"),
        "reminder_section": MessageLookupByLibrary.simpleMessage("Nhắc nhở"),
        "remove_water_button":
            MessageLookupByLibrary.simpleMessage("Giảm 250ML"),
        "reset_password":
            MessageLookupByLibrary.simpleMessage("Đặt lại mật khẩu"),
        "same_type_habit":
            MessageLookupByLibrary.simpleMessage("Các thói quen cùng loại"),
        "searching_title": MessageLookupByLibrary.simpleMessage("Tìm kiếm..."),
        "select_button": MessageLookupByLibrary.simpleMessage("Chọn"),
        "select_date_title": MessageLookupByLibrary.simpleMessage("Chọn ngày"),
        "select_range_date_title":
            MessageLookupByLibrary.simpleMessage("Chọn ngày từ ... đến ..."),
        "send_button": MessageLookupByLibrary.simpleMessage("Gửi"),
        "settings": MessageLookupByLibrary.simpleMessage("Cài đặt"),
        "show_all_figure_button":
            MessageLookupByLibrary.simpleMessage("Hiển thị các số liệu"),
        "show_less": MessageLookupByLibrary.simpleMessage("Ẩn bớt"),
        "show_more": MessageLookupByLibrary.simpleMessage("Hiển thị"),
        "start_date": MessageLookupByLibrary.simpleMessage("Ngày bắt đầu"),
        "start_tracking":
            MessageLookupByLibrary.simpleMessage("Bắt đầu theo dõi"),
        "statistic_section": MessageLookupByLibrary.simpleMessage("Thống kê"),
        "status_title": MessageLookupByLibrary.simpleMessage("Trạng thái"),
        "success_title": MessageLookupByLibrary.simpleMessage("Thành công"),
        "target_title": MessageLookupByLibrary.simpleMessage("Mục tiêu"),
        "term_and_condition_statement": MessageLookupByLibrary.simpleMessage(
            "Bằng cách đăng nhập/đăng ký, bạn chấp nhận Điều khoản và Điều kiện của chúng tôi và đồng ý với Chính sách Quyền riêng tư"),
        "terms_and_conditions":
            MessageLookupByLibrary.simpleMessage("Điều khoản & Điều kiện"),
        "theme_tile": MessageLookupByLibrary.simpleMessage("Giao diện"),
        "time_based_progress":
            MessageLookupByLibrary.simpleMessage("Quá trình theo thời gian"),
        "time_of_day_section":
            MessageLookupByLibrary.simpleMessage("Thời gian trong ngày"),
        "time_slot_heatmap": MessageLookupByLibrary.simpleMessage(
            "Biểu đồ thời gian trong ngày"),
        "today_tasks": MessageLookupByLibrary.simpleMessage("Nhiệm vụ hôm nay"),
        "total": m10,
        "total_achievement": m11,
        "total_distance":
            MessageLookupByLibrary.simpleMessage("Tổng quãng đường"),
        "total_habit":
            MessageLookupByLibrary.simpleMessage("Tất cả các thói quen"),
        "total_paused_time":
            MessageLookupByLibrary.simpleMessage("Tổng số thời gian tạm ngưng"),
        "total_streak": m12,
        "tracker_section": MessageLookupByLibrary.simpleMessage("Theo dõi"),
        "trend_section": MessageLookupByLibrary.simpleMessage("Xu hướng"),
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
        "weekly_mood":
            MessageLookupByLibrary.simpleMessage("Tâm trạng trong tuần"),
        "weekly_process_section":
            MessageLookupByLibrary.simpleMessage("Hằng tuần"),
        "wrong_password": MessageLookupByLibrary.simpleMessage(
            "Mật khẩu không chính xác, vui lòng thử lại."),
        "year_title": MessageLookupByLibrary.simpleMessage("Năm")
      };
}
