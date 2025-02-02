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

  static String m1(count) => "Thêm ${count}ML";

  static String m2(name) => "Không thể lấy thói quen: ${name}";

  static String m3(selection, percentageValue) => "${Intl.select(selection, {
            'positive': '+${percentageValue}% so với tuần trước',
            'negative': '-${percentageValue}% so với tuần trước',
            'neutral': 'Không thay đổi kể từ tuần trước',
            'other': 'Không thay đổi kể từ tuần trước',
          })}";

  static String m4(count) => "Hoàn thành ${count}%";

  static String m5(count) =>
      "${Intl.plural(count, zero: 'Chưa có người hoàn thành', one: '1 người hoàn thành', other: '${count} người hoàn thành')}";

  static String m6(count) =>
      "Tuyệt vời! Bạn đã duy trì chuỗi ${count} ngày liên tiếp";

  static String m7(count) =>
      "Tuyệt vời! Bạn đã duy trì chuỗi ${count} ngày liên tiếp";

  static String m8(count) =>
      "Tuyệt vời! Bạn đã duy trì chuỗi ${count} ngày liên tiếp";

  static String m9(completedTasks, totalTasks) =>
      "${completedTasks}/${totalTasks}";

  static String m10(value) => "Đạt được vào lúc: ${value}";

  static String m11(n) =>
      "${Intl.plural(n, one: 'Mỗi ${n} ngày', other: 'Mỗi ${n} ngày')}";

  static String m12(n) =>
      "${Intl.plural(n, one: 'Mỗi ${n} giờ', other: 'Mỗi ${n} giờ')}";

  static String m13(n) =>
      "${Intl.plural(n, one: 'Mỗi ${n} phút', other: 'Mỗi ${n} phút')}";

  static String m14(n) =>
      "${Intl.plural(n, one: 'Mỗi ${n} tháng', other: 'Mỗi ${n} tháng')}";

  static String m15(count) =>
      "${Intl.plural(count, zero: 'Thất bại: 0', one: 'Thất bại: 1', other: 'Thất bại: ${count}')}";

  static String m16(count) =>
      "${Intl.plural(count, zero: '0 thói quen', one: '1 thói quen', other: '${count} thói quen')}";

  static String m17(count) =>
      "${Intl.plural(count, zero: 'Đang tiến hành: 0', one: 'Đang tiến hành: 1', other: 'Đang tiến hành: ${count}')}";

  static String m18(dateTime) => "Hoàn thành gần nhất vào lúc: ${dateTime}";

  static String m19(count) =>
      "${Intl.plural(count, zero: 'Hôm nay', one: '1 ngày qua', other: '${count} ngày qua')}";

  static String m20(value) => "Bạn đã đi được ${value}% chặng đường";

  static String m21(count, total, time) => "Tiến độ: ${count}/${total} ${time}";

  static String m22(count) =>
      "${Intl.plural(count, zero: 'Chưa có người tham gia', one: '1 người tham gia', other: '${count} người tham gia')}";

  static String m23(count) =>
      "${Intl.plural(count, zero: 'Tạm dừng: 0', one: 'Tạm dừng: 1', other: 'Tạm dừng: ${count}')}";

  static String m24(text) => "Dừng tại ${text}";

  static String m25(count) => "Giảm ${count}ML";

  static String m26(score) =>
      "Mục tiêu SMART tốt với một số điểm cần cải thiện nhỏ. Điểm: ${score}%";

  static String m27(score) =>
      "Mục tiêu cần cải thiện ở một số lĩnh vực để thực sự SMART. Điểm: ${score}%";

  static String m28(score) =>
      "Mục tiêu cần cải thiện đáng kể để đạt tiêu chí SMART. Điểm: ${score}%";

  static String m29(count) => "Tổng số: ${count}";

  static String m30(count) =>
      "${Intl.plural(count, zero: 'Chưa có thành tựu nào', one: '1 thành tựu', other: '${count} thành tựu')}";

  static String m31(count) =>
      "${Intl.plural(count, zero: 'Chưa thực hiện chuỗi', one: 'Chuỗi 1', other: 'Chuối ${count} ngày')}";

  static String m32(name) => "Bạn đã đạt được ${name}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "accept_button": MessageLookupByLibrary.simpleMessage("Chấp nhận"),
        "account_exists_with_different_credential":
            MessageLookupByLibrary.simpleMessage(
                "Tài khoản đã tồn tại với thông tin đăng nhập khác."),
        "account_section": MessageLookupByLibrary.simpleMessage("Tài khoản"),
        "achievable_desc": MessageLookupByLibrary.simpleMessage(
            "Thực tế và có thể đạt được trong phạm vi tài nguyên và hạn chế hiện tại của bạn."),
        "achievable_suggestion_1": MessageLookupByLibrary.simpleMessage(
            "Cân nhắc làm cho mục tiêu dễ đạt hơn bằng cách tránh sử dụng các từ ngữ mang tinh tuyệt đối"),
        "achievable_suggestion_2": MessageLookupByLibrary.simpleMessage(
            "Tránh những mục tiêu không rõ ràng, không thể đo lường hoặc đạt được"),
        "achievable_title":
            MessageLookupByLibrary.simpleMessage("Đạt được - Achievable"),
        "achieved": m0,
        "achieved_habit":
            MessageLookupByLibrary.simpleMessage("Các thói quen đã đạt được"),
        "achieved_statistic_page":
            MessageLookupByLibrary.simpleMessage("Đã đạt được"),
        "achieved_title": MessageLookupByLibrary.simpleMessage("Đạt đuược:"),
        "achievement_done": MessageLookupByLibrary.simpleMessage("Thành tựu"),
        "achievements_screen":
            MessageLookupByLibrary.simpleMessage("Thành tựu"),
        "action_creative_build":
            MessageLookupByLibrary.simpleMessage("xây dựng"),
        "action_creative_compose":
            MessageLookupByLibrary.simpleMessage("sáng tác"),
        "action_creative_create":
            MessageLookupByLibrary.simpleMessage("tạo ra"),
        "action_creative_design":
            MessageLookupByLibrary.simpleMessage("thiết kế"),
        "action_creative_develop":
            MessageLookupByLibrary.simpleMessage("phát triển"),
        "action_creative_draw": MessageLookupByLibrary.simpleMessage("vẽ"),
        "action_creative_paint": MessageLookupByLibrary.simpleMessage("sơn"),
        "action_creative_write": MessageLookupByLibrary.simpleMessage("viết"),
        "action_exercise_gym":
            MessageLookupByLibrary.simpleMessage("đến phòng tập"),
        "action_exercise_jog": MessageLookupByLibrary.simpleMessage("chạy bộ"),
        "action_exercise_run": MessageLookupByLibrary.simpleMessage("chạy"),
        "action_exercise_stretch":
            MessageLookupByLibrary.simpleMessage("giãn cơ"),
        "action_exercise_swim": MessageLookupByLibrary.simpleMessage("bơi"),
        "action_exercise_walk": MessageLookupByLibrary.simpleMessage("đi bộ"),
        "action_exercise_workout":
            MessageLookupByLibrary.simpleMessage("tập luyện"),
        "action_exercise_yoga":
            MessageLookupByLibrary.simpleMessage("tập yoga"),
        "action_health_breathe": MessageLookupByLibrary.simpleMessage("thở"),
        "action_health_drink": MessageLookupByLibrary.simpleMessage("uống"),
        "action_health_eat": MessageLookupByLibrary.simpleMessage("ăn"),
        "action_health_meditate": MessageLookupByLibrary.simpleMessage("thiền"),
        "action_health_relax": MessageLookupByLibrary.simpleMessage("thư giãn"),
        "action_health_rest": MessageLookupByLibrary.simpleMessage("nghỉ ngơi"),
        "action_health_sleep": MessageLookupByLibrary.simpleMessage("ngủ"),
        "action_improvement_decrease":
            MessageLookupByLibrary.simpleMessage("giảm"),
        "action_improvement_enhance":
            MessageLookupByLibrary.simpleMessage("nâng cao"),
        "action_improvement_improve":
            MessageLookupByLibrary.simpleMessage("cải thiện"),
        "action_improvement_increase":
            MessageLookupByLibrary.simpleMessage("tăng"),
        "action_improvement_optimize":
            MessageLookupByLibrary.simpleMessage("tối ưu hóa"),
        "action_improvement_reduce":
            MessageLookupByLibrary.simpleMessage("giảm thiểu"),
        "action_improvement_upgrade":
            MessageLookupByLibrary.simpleMessage("nâng cấp"),
        "action_learning_learn":
            MessageLookupByLibrary.simpleMessage("học hỏi"),
        "action_learning_master":
            MessageLookupByLibrary.simpleMessage("thành thạo"),
        "action_learning_practice":
            MessageLookupByLibrary.simpleMessage("thực hành"),
        "action_learning_read": MessageLookupByLibrary.simpleMessage("đọc"),
        "action_learning_research":
            MessageLookupByLibrary.simpleMessage("nghiên cứu"),
        "action_learning_revise":
            MessageLookupByLibrary.simpleMessage("ôn tập"),
        "action_learning_study": MessageLookupByLibrary.simpleMessage("học"),
        "action_learning_write": MessageLookupByLibrary.simpleMessage("viết"),
        "action_productivity_accomplish":
            MessageLookupByLibrary.simpleMessage("thực hiện"),
        "action_productivity_achieve":
            MessageLookupByLibrary.simpleMessage("đạt được"),
        "action_productivity_complete":
            MessageLookupByLibrary.simpleMessage("hoàn thành"),
        "action_productivity_continue":
            MessageLookupByLibrary.simpleMessage("tiếp tục"),
        "action_productivity_do": MessageLookupByLibrary.simpleMessage("làm"),
        "action_productivity_finish":
            MessageLookupByLibrary.simpleMessage("kết thúc"),
        "action_productivity_start":
            MessageLookupByLibrary.simpleMessage("bắt đầu"),
        "action_productivity_work":
            MessageLookupByLibrary.simpleMessage("làm việc về"),
        "action_social_call": MessageLookupByLibrary.simpleMessage("gọi điện"),
        "action_social_connect":
            MessageLookupByLibrary.simpleMessage("kết nối với"),
        "action_social_email":
            MessageLookupByLibrary.simpleMessage("gửi email"),
        "action_social_help": MessageLookupByLibrary.simpleMessage("giúp đỡ"),
        "action_social_meet": MessageLookupByLibrary.simpleMessage("gặp gỡ"),
        "action_social_spend":
            MessageLookupByLibrary.simpleMessage("dành thời gian với"),
        "action_social_text": MessageLookupByLibrary.simpleMessage("nhắn tin"),
        "action_social_visit": MessageLookupByLibrary.simpleMessage("thăm"),
        "action_time_allocate": MessageLookupByLibrary.simpleMessage("phân bổ"),
        "action_time_limit": MessageLookupByLibrary.simpleMessage("giới hạn"),
        "action_time_manage": MessageLookupByLibrary.simpleMessage("quản lý"),
        "action_time_organize": MessageLookupByLibrary.simpleMessage("tổ chức"),
        "action_time_plan":
            MessageLookupByLibrary.simpleMessage("lập kế hoạch"),
        "action_time_schedule":
            MessageLookupByLibrary.simpleMessage("lên lịch"),
        "action_time_spend": MessageLookupByLibrary.simpleMessage("dành"),
        "action_tracking_analyze":
            MessageLookupByLibrary.simpleMessage("phân tích"),
        "action_tracking_count": MessageLookupByLibrary.simpleMessage("đếm"),
        "action_tracking_log": MessageLookupByLibrary.simpleMessage("ghi chép"),
        "action_tracking_measure":
            MessageLookupByLibrary.simpleMessage("đo lường"),
        "action_tracking_monitor":
            MessageLookupByLibrary.simpleMessage("giám sát"),
        "action_tracking_record":
            MessageLookupByLibrary.simpleMessage("ghi lại"),
        "action_tracking_track":
            MessageLookupByLibrary.simpleMessage("theo dõi"),
        "active_button": MessageLookupByLibrary.simpleMessage("Kích hoạt"),
        "active_habit": MessageLookupByLibrary.simpleMessage(
            "Các thói quen đang thực hiện"),
        "active_statistic_page":
            MessageLookupByLibrary.simpleMessage("Đang thực hiện"),
        "add_goal_desc": MessageLookupByLibrary.simpleMessage(
            "Mô tả mục tiêu (Thông tin chi tiết về mục tiêu của thói quen)"),
        "add_habit": MessageLookupByLibrary.simpleMessage("Add Habit"),
        "add_habit_desc": MessageLookupByLibrary.simpleMessage(
            "Mô tả thói quen (Mục đích và lợi ích của thói quen đó)"),
        "add_habit_manually":
            MessageLookupByLibrary.simpleMessage("Tự tạo thói quen"),
        "add_habit_not_enough_info": MessageLookupByLibrary.simpleMessage(
            "Vui lòng cung cấp ít nhất một trong các thông tin: tên thói quen, mô tả hoặc mục tiêu ngắn gọn để tạo ra mục tiêu SMART chính xác."),
        "add_habit_with_few_words_option": MessageLookupByLibrary.simpleMessage(
            "Tạo thói quen mới chỉ với vài từ"),
        "add_reminder":
            MessageLookupByLibrary.simpleMessage("Thêm lịch nhắc nhở"),
        "add_success": MessageLookupByLibrary.simpleMessage("Tạo thành công"),
        "add_water_button": m1,
        "add_your_own_habit": MessageLookupByLibrary.simpleMessage(
            "Tự thiết lập thói quen của bạn"),
        "additional_information":
            MessageLookupByLibrary.simpleMessage("Thông tin bổ sung"),
        "afternoon_greeting":
            MessageLookupByLibrary.simpleMessage("Chào buổi trưa"),
        "afternoon_tile": MessageLookupByLibrary.simpleMessage("Buổi chiều"),
        "age_field": MessageLookupByLibrary.simpleMessage("Tuổi"),
        "ai_habit_generate_page_title": MessageLookupByLibrary.simpleMessage(
            "Tạo ra thói quen chuẩn SMART với vài từ"),
        "all_achievements_tab": MessageLookupByLibrary.simpleMessage(
            "Tất cả các thành tựu đã đạt được"),
        "all_detail_history":
            MessageLookupByLibrary.simpleMessage("Chi tiết các lịch sử"),
        "all_habits": MessageLookupByLibrary.simpleMessage("Tất cả thói quen"),
        "all_selection": MessageLookupByLibrary.simpleMessage("Tất cả"),
        "all_statistic_page": MessageLookupByLibrary.simpleMessage("Tất cả"),
        "ask_ai_button": MessageLookupByLibrary.simpleMessage(
            "Tạo một thói quen chuẩn SMART"),
        "ask_ai_field": MessageLookupByLibrary.simpleMessage(
            "Hãy cho tôi biết bạn đang muốn thực hiện gì..."),
        "attendance_button":
            MessageLookupByLibrary.simpleMessage("Tham gia thử thách"),
        "authentication_choice":
            MessageLookupByLibrary.simpleMessage("Đăng nhập/Đăng ký"),
        "author_aristotle": MessageLookupByLibrary.simpleMessage("Aristotle"),
        "author_dwayne_johnson":
            MessageLookupByLibrary.simpleMessage("Dwayne Johnson"),
        "author_james_clear":
            MessageLookupByLibrary.simpleMessage("James Clear"),
        "avg_time":
            MessageLookupByLibrary.simpleMessage("Thời gian trung bình"),
        "bad_suggestion_1":
            MessageLookupByLibrary.simpleMessage("Có chút khó khăn"),
        "bad_suggestion_2":
            MessageLookupByLibrary.simpleMessage("Cần cải thiện"),
        "best_time":
            MessageLookupByLibrary.simpleMessage("Khoảng thời gian tốt nhất"),
        "birth_date": MessageLookupByLibrary.simpleMessage("Sinh nhật"),
        "cancel_button": MessageLookupByLibrary.simpleMessage("Hủy bỏ"),
        "cannot_generate_habit":
            MessageLookupByLibrary.simpleMessage("Không thể tạo thói quen"),
        "cannot_get_any_habit":
            MessageLookupByLibrary.simpleMessage("Không thể lấy các thói quen"),
        "cannot_get_any_history": MessageLookupByLibrary.simpleMessage(
            "Không thể lấy bất cứ lịch sử nào"),
        "cannot_get_habit_with_name": m2,
        "cannot_store_history":
            MessageLookupByLibrary.simpleMessage("Không thể lưu lịch sử"),
        "cannot_update_habit": MessageLookupByLibrary.simpleMessage(
            "Không thể cập nhật thói quen"),
        "category_based_completion_rate": MessageLookupByLibrary.simpleMessage(
            "Tỉ lệ hoàn thành theo danh mục"),
        "category_distribution":
            MessageLookupByLibrary.simpleMessage("Phân bố theo danh mục"),
        "challenge_level": MessageLookupByLibrary.simpleMessage("Cấp độ"),
        "change_from_last_week": m3,
        "cm_unit": MessageLookupByLibrary.simpleMessage("cm"),
        "collection_tab": MessageLookupByLibrary.simpleMessage("Bộ sưu tập"),
        "community_challenges":
            MessageLookupByLibrary.simpleMessage("Thử thách cộng đồng"),
        "completed_progress": m4,
        "completion": m5,
        "completion_rate":
            MessageLookupByLibrary.simpleMessage("Tỉ lệ hoàn thành"),
        "compound_effect":
            MessageLookupByLibrary.simpleMessage("Hiệu ứng Compound"),
        "compound_effect_description": MessageLookupByLibrary.simpleMessage(
            "Cải thiện 1% mỗi ngày sẽ giúp bạn tốt hơn 37 lần sau một năm."),
        "confirm_password_field":
            MessageLookupByLibrary.simpleMessage("Xác nhận mật khẩu"),
        "congratulation_title":
            MessageLookupByLibrary.simpleMessage("Chúc mừng"),
        "create_new_challenge":
            MessageLookupByLibrary.simpleMessage("Tạo những thử thách mới"),
        "current_distance":
            MessageLookupByLibrary.simpleMessage("Quãng đường hiện tại"),
        "current_progress":
            MessageLookupByLibrary.simpleMessage("Tiến độ hiện tại"),
        "custom_unit": MessageLookupByLibrary.simpleMessage("tùy chỉnh"),
        "daily_completed": MessageLookupByLibrary.simpleMessage(
            "Bạn đã hoàn thành thói quen cho ngày hôm nay"),
        "daily_paused": MessageLookupByLibrary.simpleMessage(
            "Bạn đã tạm dừng thói quen này hôm nay"),
        "daily_routine":
            MessageLookupByLibrary.simpleMessage("Lối sống hằng ngày"),
        "dark_theme": MessageLookupByLibrary.simpleMessage("Chế độ tối"),
        "date_title": MessageLookupByLibrary.simpleMessage("Ngày"),
        "dawn_tile": MessageLookupByLibrary.simpleMessage("Bình minh"),
        "day_title": MessageLookupByLibrary.simpleMessage("Ngày"),
        "day_unit": MessageLookupByLibrary.simpleMessage("ngày"),
        "default_greeting": MessageLookupByLibrary.simpleMessage("Chào"),
        "default_long_streak": m6,
        "default_medium_streak": m7,
        "default_short_streak": m8,
        "delete_button": MessageLookupByLibrary.simpleMessage("Xóa"),
        "delete_title":
            MessageLookupByLibrary.simpleMessage("Bạn có chắc muốn xóa không?"),
        "delete_warning": MessageLookupByLibrary.simpleMessage(
            "Hành động này sẽ không thể hoàn tác"),
        "detail_section": MessageLookupByLibrary.simpleMessage("Chi tiết"),
        "discover_tab": MessageLookupByLibrary.simpleMessage(
            "Khám phá thêm những thử thách mới"),
        "display_name": MessageLookupByLibrary.simpleMessage("Tên"),
        "done_tasks": m9,
        "duration_title":
            MessageLookupByLibrary.simpleMessage("Thời gian thực hiện"),
        "dusk_tile": MessageLookupByLibrary.simpleMessage("Hoàng hôn"),
        "earned_at": m10,
        "edit_button": MessageLookupByLibrary.simpleMessage("Chỉnh sửa"),
        "education_and_improvement":
            MessageLookupByLibrary.simpleMessage("Giáo dục và phát triển"),
        "email_already_in_use": MessageLookupByLibrary.simpleMessage(
            "Đã có tài khoản sử dụng email này."),
        "empty_field": MessageLookupByLibrary.simpleMessage(
            "Vui lòng không để trống trường này"),
        "enable_button": MessageLookupByLibrary.simpleMessage("Cho phép"),
        "enable_notifications":
            MessageLookupByLibrary.simpleMessage("Cho phép gửi thông báo"),
        "end_date": MessageLookupByLibrary.simpleMessage("Ngày kết thúc"),
        "end_value_must_be_greater_than_start":
            MessageLookupByLibrary.simpleMessage(
                "Giá trị kết thúc phải lớn hơn giá trị bắt đầu"),
        "english_choice": MessageLookupByLibrary.simpleMessage("Tiếng Anh"),
        "evening_greeting":
            MessageLookupByLibrary.simpleMessage("Chào buổi chiểu"),
        "every_n_day": m11,
        "every_n_hour": m12,
        "every_n_minute": m13,
        "every_n_month": m14,
        "exercise_habit_desc": MessageLookupByLibrary.simpleMessage(
            "Tăng cường sức khỏe và năng lượng bằng cách tập thể dục mỗi sáng."),
        "exercise_habit_goal_desc": MessageLookupByLibrary.simpleMessage(
            "Tập thể dục đủ 30 phút mỗi sáng để cải thiện sức khỏe và thể lực."),
        "exercise_habit_title":
            MessageLookupByLibrary.simpleMessage("Tập thể dục buổi sáng"),
        "exercise_reminder_title":
            MessageLookupByLibrary.simpleMessage("Đến giờ tập thể dục"),
        "failed": m15,
        "failed_habit":
            MessageLookupByLibrary.simpleMessage("Các thói quen đã thất bại"),
        "failed_rate": MessageLookupByLibrary.simpleMessage("Tỉ lệ thất bại"),
        "failed_statistic_page":
            MessageLookupByLibrary.simpleMessage("Thất bại"),
        "failed_title": MessageLookupByLibrary.simpleMessage("Thất bại:"),
        "failure_title": MessageLookupByLibrary.simpleMessage("Thất bại"),
        "fastest_time":
            MessageLookupByLibrary.simpleMessage("Thời gian nhanh nhất"),
        "find_button": MessageLookupByLibrary.simpleMessage("Tìm kiếm"),
        "first_achievement_title":
            MessageLookupByLibrary.simpleMessage("Thành tựu đầu tiên"),
        "freq_daily": MessageLookupByLibrary.simpleMessage("Hằng ngày"),
        "freq_monthly": MessageLookupByLibrary.simpleMessage("Hằng tháng"),
        "freq_value": MessageLookupByLibrary.simpleMessage("Giá trị"),
        "freq_yearly": MessageLookupByLibrary.simpleMessage("Hằng năm"),
        "friend_title": MessageLookupByLibrary.simpleMessage("anh bạn"),
        "gender_field": MessageLookupByLibrary.simpleMessage("Giới tính"),
        "general_section": MessageLookupByLibrary.simpleMessage("Chung"),
        "generate_habit_button":
            MessageLookupByLibrary.simpleMessage("Tạo thói quen"),
        "get_preset_habit_option":
            MessageLookupByLibrary.simpleMessage("Chọn các thói quen có sẵn"),
        "glass_unit": MessageLookupByLibrary.simpleMessage("ly"),
        "go_home_button": MessageLookupByLibrary.simpleMessage("Về trang chủ"),
        "goal_completion": MessageLookupByLibrary.simpleMessage("Hoàn thành"),
        "goal_count": MessageLookupByLibrary.simpleMessage("Đếm"),
        "goal_custom": MessageLookupByLibrary.simpleMessage("Tùy chỉnh"),
        "goal_desc": MessageLookupByLibrary.simpleMessage("Mô tả mục tiêu"),
        "goal_distance": MessageLookupByLibrary.simpleMessage("Khoảng cách"),
        "goal_duration": MessageLookupByLibrary.simpleMessage("Thời lượng"),
        "goal_recommend_with_no_internet_alert":
            MessageLookupByLibrary.simpleMessage(
                "Xin lưu ý, độ chính xác của mục tiêu có thể bị ảnh hưởng nếu không có kết nối internet. Vui lòng kiểm tra kết nối và thử lại."),
        "goal_type": MessageLookupByLibrary.simpleMessage("Loại mục tiêu"),
        "goal_unit": MessageLookupByLibrary.simpleMessage("Đ.vị"),
        "goal_unit_value": MessageLookupByLibrary.simpleMessage("Giá trị"),
        "good_suggestion_1":
            MessageLookupByLibrary.simpleMessage("Tiến triển tốt"),
        "good_suggestion_2":
            MessageLookupByLibrary.simpleMessage("Cảm giác hoàn thành tốt"),
        "great_suggestion_1": MessageLookupByLibrary.simpleMessage("Bứt phá!"),
        "great_suggestion_2":
            MessageLookupByLibrary.simpleMessage("Tốt nhất từ trước đến nay!"),
        "habit_category":
            MessageLookupByLibrary.simpleMessage("Loại thói quen"),
        "habit_category_creativity":
            MessageLookupByLibrary.simpleMessage("Sáng tạo"),
        "habit_category_education":
            MessageLookupByLibrary.simpleMessage("Học tập"),
        "habit_category_environmental":
            MessageLookupByLibrary.simpleMessage("Môi trường"),
        "habit_category_field_hint":
            MessageLookupByLibrary.simpleMessage("Chọn loại thói quen"),
        "habit_category_finance":
            MessageLookupByLibrary.simpleMessage("Tài chính"),
        "habit_category_health":
            MessageLookupByLibrary.simpleMessage("Sức khỏe"),
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
        "habit_desc": MessageLookupByLibrary.simpleMessage("Mô tả thói quen"),
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
        "habit_frequency": MessageLookupByLibrary.simpleMessage("Tần suất"),
        "habit_generated_title":
            MessageLookupByLibrary.simpleMessage("Thói quen chuẩn SMART"),
        "habit_goal":
            MessageLookupByLibrary.simpleMessage("Mục tiêu thói quen"),
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
        "habit_quote_1": MessageLookupByLibrary.simpleMessage(
            "Có công mài sắt, có ngày nên kim"),
        "habit_quote_2": MessageLookupByLibrary.simpleMessage("Có chí thì nên"),
        "habit_quote_3":
            MessageLookupByLibrary.simpleMessage("Tích tiểu thành đại"),
        "habit_quote_4": MessageLookupByLibrary.simpleMessage(
            "Chớ thấy sóng cả mà ngã tay chèo"),
        "habit_quote_5": MessageLookupByLibrary.simpleMessage(
            "Mưa dầm thấm lâu, mưa lâu thấm đất"),
        "habit_status_distribution":
            MessageLookupByLibrary.simpleMessage("Phân bố theo trạng thái"),
        "habits": m16,
        "health_and_sport":
            MessageLookupByLibrary.simpleMessage("Sức khỏe và thể thao"),
        "help_tile": MessageLookupByLibrary.simpleMessage("Trợ giúp"),
        "history_empty": MessageLookupByLibrary.simpleMessage(
            "Không có lịch sử nào được tìm thấy"),
        "history_section":
            MessageLookupByLibrary.simpleMessage("Lịch sử thực hiện"),
        "hour_unit": MessageLookupByLibrary.simpleMessage("giờ"),
        "imperial_unit": MessageLookupByLibrary.simpleMessage("Hệ Anh"),
        "in_progress": m17,
        "in_progress_habit": MessageLookupByLibrary.simpleMessage(
            "Các thói quen đang thực hiện"),
        "in_progress_title":
            MessageLookupByLibrary.simpleMessage("Đang tiến hành:"),
        "inactive_button":
            MessageLookupByLibrary.simpleMessage("Không kích hoạt"),
        "invalid_age": MessageLookupByLibrary.simpleMessage(
            "Vui lòng chọn một độ tuổi phù hợp"),
        "invalid_credential": MessageLookupByLibrary.simpleMessage(
            "Email hoặc mật khẩu không hợp lệ."),
        "invalid_email": MessageLookupByLibrary.simpleMessage(
            "Email không hợp lệ hoặc được định dạng sai."),
        "invalid_end_date": MessageLookupByLibrary.simpleMessage(
            "Ngày kết thúc không thể trước ngày bắt đầu"),
        "invalid_form": MessageLookupByLibrary.simpleMessage(
            "Vui lòng kiểm tra lại thông tin của bạn"),
        "invalid_habit_prompt": MessageLookupByLibrary.simpleMessage(
            "Vui lòng cung cấp thêm thông tin để tạo ra một thói quen chuẩn SMART hơn"),
        "invalid_num": MessageLookupByLibrary.simpleMessage(
            "Vui lòng nhập một số lớn hơn 0"),
        "invalid_password": MessageLookupByLibrary.simpleMessage(
            "Mật khẩu phải có ít nhất 6 ký tự"),
        "invalid_phone":
            MessageLookupByLibrary.simpleMessage("Số điện thoại không hợp lệ"),
        "invalid_reminders_message": MessageLookupByLibrary.simpleMessage(
            "Cần ít nhất một thời gian để reminder"),
        "invalid_start_date": MessageLookupByLibrary.simpleMessage(
            "Ngày bắt đầu không thể sau ngày kết thúc"),
        "invalid_verification_code": MessageLookupByLibrary.simpleMessage(
            "Mã xác minh nhận được không hợp lệ."),
        "invalid_verification_id": MessageLookupByLibrary.simpleMessage(
            "ID xác minh nhận được không hợp lệ."),
        "keep_button": MessageLookupByLibrary.simpleMessage("Giữ"),
        "km_unit": MessageLookupByLibrary.simpleMessage("km"),
        "know_more_about_habit":
            MessageLookupByLibrary.simpleMessage("Hiểu về thói quen"),
        "l_unit": MessageLookupByLibrary.simpleMessage("l"),
        "language_tile": MessageLookupByLibrary.simpleMessage("Ngôn ngữ"),
        "last_completed_at": m18,
        "last_n_day": m19,
        "latest_achievement_title":
            MessageLookupByLibrary.simpleMessage("Thành tựu gần đây"),
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
        "longest_time":
            MessageLookupByLibrary.simpleMessage("Thời gian lâu nhất"),
        "m_unit": MessageLookupByLibrary.simpleMessage("m"),
        "manage_account_choice":
            MessageLookupByLibrary.simpleMessage("Quản lý tài khoản"),
        "mark_as_done": MessageLookupByLibrary.simpleMessage("Đã thực hiện"),
        "mark_as_pause": MessageLookupByLibrary.simpleMessage("Tạm dừng"),
        "measurable_excellent": MessageLookupByLibrary.simpleMessage(
            "Mục tiêu có các chỉ số và phương pháp theo dõi rõ ràng"),
        "measurable_good": MessageLookupByLibrary.simpleMessage(
            "Mục tiêu có thể đo lường được nhưng cần chỉ số rõ ràng hơn"),
        "measurable_gram": MessageLookupByLibrary.simpleMessage("g"),
        "measurable_hour": MessageLookupByLibrary.simpleMessage("h"),
        "measurable_kilogram": MessageLookupByLibrary.simpleMessage("kg"),
        "measurable_kilometer": MessageLookupByLibrary.simpleMessage("km"),
        "measurable_liter": MessageLookupByLibrary.simpleMessage("l"),
        "measurable_meter": MessageLookupByLibrary.simpleMessage("m"),
        "measurable_mile": MessageLookupByLibrary.simpleMessage("mile"),
        "measurable_milliliter": MessageLookupByLibrary.simpleMessage("ml"),
        "measurable_minute": MessageLookupByLibrary.simpleMessage("phút"),
        "measurable_needs_work": MessageLookupByLibrary.simpleMessage(
            "Mục tiêu cần cách thức rõ ràng hơn để đo lường tiến độ"),
        "measurable_negative_decline":
            MessageLookupByLibrary.simpleMessage("suy giảm"),
        "measurable_negative_decrease":
            MessageLookupByLibrary.simpleMessage("giảm"),
        "measurable_negative_diminish":
            MessageLookupByLibrary.simpleMessage("giảm sút"),
        "measurable_negative_fail":
            MessageLookupByLibrary.simpleMessage("thất bại"),
        "measurable_negative_lose": MessageLookupByLibrary.simpleMessage("mất"),
        "measurable_negative_revert":
            MessageLookupByLibrary.simpleMessage("quay lại"),
        "measurable_negative_weaken":
            MessageLookupByLibrary.simpleMessage("yếu đi"),
        "measurable_page": MessageLookupByLibrary.simpleMessage("trang"),
        "measurable_poor": MessageLookupByLibrary.simpleMessage(
            "Mục tiêu thiếu tiêu chí đo lường"),
        "measurable_positive_accomplish":
            MessageLookupByLibrary.simpleMessage("hoàn tất"),
        "measurable_positive_achieve":
            MessageLookupByLibrary.simpleMessage("đạt được"),
        "measurable_positive_advance":
            MessageLookupByLibrary.simpleMessage("tiến tới"),
        "measurable_positive_attain":
            MessageLookupByLibrary.simpleMessage("đạt tới"),
        "measurable_positive_boost":
            MessageLookupByLibrary.simpleMessage("tăng cường"),
        "measurable_positive_build":
            MessageLookupByLibrary.simpleMessage("xây dựng"),
        "measurable_positive_complete":
            MessageLookupByLibrary.simpleMessage("hoàn thành"),
        "measurable_positive_cultivate":
            MessageLookupByLibrary.simpleMessage("nuôi dưỡng"),
        "measurable_positive_deliver":
            MessageLookupByLibrary.simpleMessage("hoàn thành"),
        "measurable_positive_develop":
            MessageLookupByLibrary.simpleMessage("phát triển"),
        "measurable_positive_enhance":
            MessageLookupByLibrary.simpleMessage("nâng cao"),
        "measurable_positive_expand":
            MessageLookupByLibrary.simpleMessage("mở rộng"),
        "measurable_positive_finalize":
            MessageLookupByLibrary.simpleMessage("hoàn tất"),
        "measurable_positive_finish":
            MessageLookupByLibrary.simpleMessage("hoàn tất"),
        "measurable_positive_growth":
            MessageLookupByLibrary.simpleMessage("tăng trưởng"),
        "measurable_positive_improve":
            MessageLookupByLibrary.simpleMessage("cải thiện"),
        "measurable_positive_increase":
            MessageLookupByLibrary.simpleMessage("tăng"),
        "measurable_positive_master":
            MessageLookupByLibrary.simpleMessage("làm chủ"),
        "measurable_positive_optimize":
            MessageLookupByLibrary.simpleMessage("tối ưu hóa"),
        "measurable_positive_perfect":
            MessageLookupByLibrary.simpleMessage("hoàn thiện"),
        "measurable_positive_progress":
            MessageLookupByLibrary.simpleMessage("tiến bộ"),
        "measurable_positive_raise":
            MessageLookupByLibrary.simpleMessage("nâng lên"),
        "measurable_positive_reach":
            MessageLookupByLibrary.simpleMessage("đạt được"),
        "measurable_positive_realize":
            MessageLookupByLibrary.simpleMessage("thực hiện"),
        "measurable_positive_refine":
            MessageLookupByLibrary.simpleMessage("tinh chỉnh"),
        "measurable_positive_strengthen":
            MessageLookupByLibrary.simpleMessage("củng cố"),
        "measurable_positive_succeed":
            MessageLookupByLibrary.simpleMessage("thành công"),
        "measurable_rep": MessageLookupByLibrary.simpleMessage("lần"),
        "measurable_second": MessageLookupByLibrary.simpleMessage("giây"),
        "measurable_set": MessageLookupByLibrary.simpleMessage("hiệp"),
        "measurable_step": MessageLookupByLibrary.simpleMessage("bước"),
        "measurable_suggestion_1": MessageLookupByLibrary.simpleMessage(
            "Thêm số liệu cụ thể để theo dõi tiến độ"),
        "measurable_suggestion_2": MessageLookupByLibrary.simpleMessage(
            "Thêm cách đo lường thành công"),
        "measurable_title":
            MessageLookupByLibrary.simpleMessage("Đo lường - Measurable"),
        "measurement_desc": MessageLookupByLibrary.simpleMessage(
            "Bao gồm các con số hoặc hành động cụ thể có thể được theo dõi và đánh giá."),
        "measurement_unit_title":
            MessageLookupByLibrary.simpleMessage("Đơn vị đo lường"),
        "meditation_habit_desc": MessageLookupByLibrary.simpleMessage(
            "Thư giãn và giảm căng thẳng bằng cách thiền 5 phút mỗi sáng."),
        "meditation_habit_goal_desc": MessageLookupByLibrary.simpleMessage(
            "Dành 5 phút mỗi sáng để thiền và tăng cường sự tập trung."),
        "meditation_habit_title":
            MessageLookupByLibrary.simpleMessage("Thiền 5 phút"),
        "meditation_reminder_title":
            MessageLookupByLibrary.simpleMessage("Đến giờ thiền"),
        "mental_health":
            MessageLookupByLibrary.simpleMessage("Sức khỏe tinh thần"),
        "metric_unit": MessageLookupByLibrary.simpleMessage("Hệ mét"),
        "miles_unit": MessageLookupByLibrary.simpleMessage("dặm"),
        "minute_unit": MessageLookupByLibrary.simpleMessage("phút"),
        "miss_title": MessageLookupByLibrary.simpleMessage("Bỏ lỡ"),
        "ml_unit": MessageLookupByLibrary.simpleMessage("ml"),
        "month_title": MessageLookupByLibrary.simpleMessage("Tháng"),
        "monthly_process_section":
            MessageLookupByLibrary.simpleMessage("Hằng tháng"),
        "mood_bad": MessageLookupByLibrary.simpleMessage("Tệ"),
        "mood_distribution":
            MessageLookupByLibrary.simpleMessage("Phân bố tâm trạng"),
        "mood_good": MessageLookupByLibrary.simpleMessage("Tốt"),
        "mood_great": MessageLookupByLibrary.simpleMessage("Tuyệt vời"),
        "mood_neutral": MessageLookupByLibrary.simpleMessage("Bình thường"),
        "mood_terrible": MessageLookupByLibrary.simpleMessage("Rất tệ"),
        "mood_title": MessageLookupByLibrary.simpleMessage("Tâm trạng"),
        "more_title": MessageLookupByLibrary.simpleMessage("Nhiều"),
        "morning_greeting":
            MessageLookupByLibrary.simpleMessage("Chào buổi sáng"),
        "most_achieved_level": MessageLookupByLibrary.simpleMessage(
            "Loại thành tưu hay hoàn thành nhất"),
        "most_mood": MessageLookupByLibrary.simpleMessage(
            "Tâm trạng xuất hiện nhiều nhất"),
        "most_reason":
            MessageLookupByLibrary.simpleMessage("Nguyên nhân chủ yếu"),
        "my_custom_challenge_tab":
            MessageLookupByLibrary.simpleMessage("Được tạo bởi tôi"),
        "my_reward_tab": MessageLookupByLibrary.simpleMessage("Phần thưởng"),
        "neutral_suggestion_1":
            MessageLookupByLibrary.simpleMessage("Hoàn thành theo kế hoạch"),
        "neutral_suggestion_2":
            MessageLookupByLibrary.simpleMessage("Bình thường"),
        "next_habits_button":
            MessageLookupByLibrary.simpleMessage("Trang kế tiếp"),
        "night_greeting": MessageLookupByLibrary.simpleMessage("Chào buổi tối"),
        "no_data_title": MessageLookupByLibrary.simpleMessage("Trống"),
        "no_date_selected":
            MessageLookupByLibrary.simpleMessage("Chưa ngày nào được chọn"),
        "no_habit_found": MessageLookupByLibrary.simpleMessage(
            "Không tìm thấy thói quen nào"),
        "no_habit_item_selected": MessageLookupByLibrary.simpleMessage(
            "Vui lòng chọn ít nhất một thói quen để thêm"),
        "no_task_today": MessageLookupByLibrary.simpleMessage(
            "Không có nhiệm vụ nào cần hoàn thành"),
        "not_allow_track": MessageLookupByLibrary.simpleMessage(
            "Chúng tôi không được cấp quyền để theo dõi quãng đường di chuyển của bạn"),
        "not_found": MessageLookupByLibrary.simpleMessage("Không tìm thấy"),
        "not_now_button":
            MessageLookupByLibrary.simpleMessage("Không phải bây giờ"),
        "note_hint": MessageLookupByLibrary.simpleMessage(
            "Viết ghi chú của bạn tại đây...."),
        "note_title": MessageLookupByLibrary.simpleMessage("Ghi chú"),
        "notification_permission_request": MessageLookupByLibrary.simpleMessage(
            "Để giúp bạn xây dựng thói quen tốt hơn, chúng tôi muốn gửi cho bạn các thông báo nhắc nhở.\nBạn có muốn bật thông báo không?"),
        "notification_screen_title":
            MessageLookupByLibrary.simpleMessage("Giữ vững thói quen của bạn!"),
        "notifications": MessageLookupByLibrary.simpleMessage("Thông báo"),
        "notify_at":
            MessageLookupByLibrary.simpleMessage("Thông báo vào lúc: "),
        "on_your_way": m20,
        "operation_not_allowed": MessageLookupByLibrary.simpleMessage(
            "Hoạt động không được phép. Vui lòng liên hệ hỗ trợ."),
        "out_of_range": MessageLookupByLibrary.simpleMessage(
            "Số hiện tại đang vượt quá mức"),
        "overall_completion_rate":
            MessageLookupByLibrary.simpleMessage("Tổng tỉ lệ hoàn thành"),
        "overall_progress": m21,
        "page_unit": MessageLookupByLibrary.simpleMessage("trang"),
        "pareto_principle":
            MessageLookupByLibrary.simpleMessage("Quy luật Pareto"),
        "pareto_principle_description": MessageLookupByLibrary.simpleMessage(
            "20% thói quen đúng đắn sẽ mang lại 80% kết quả tích cực."),
        "participant": m22,
        "password_field": MessageLookupByLibrary.simpleMessage("Mật khẩu"),
        "passwords_do_not_match":
            MessageLookupByLibrary.simpleMessage("Mật khẩu không trùng khớp"),
        "pause_button": MessageLookupByLibrary.simpleMessage("Tạm dừng"),
        "pause_tracking":
            MessageLookupByLibrary.simpleMessage("Tạm dừng theo dõi"),
        "paused": m23,
        "paused_at": m24,
        "paused_habit":
            MessageLookupByLibrary.simpleMessage("Các thói quen đang tạm dừng"),
        "paused_statistic_page":
            MessageLookupByLibrary.simpleMessage("Tạm ngưng"),
        "paused_title": MessageLookupByLibrary.simpleMessage("Tạm dừng:"),
        "personal_achievements":
            MessageLookupByLibrary.simpleMessage("Thành tựu cá nhân"),
        "personal_info_section":
            MessageLookupByLibrary.simpleMessage("Thông tin cá nhân"),
        "phone_number": MessageLookupByLibrary.simpleMessage("Điện thoại"),
        "pick_color": MessageLookupByLibrary.simpleMessage("Chọn màu"),
        "pick_icon": MessageLookupByLibrary.simpleMessage("Chọn icon"),
        "power_of_timing":
            MessageLookupByLibrary.simpleMessage("Sức mạnh của thời điểm"),
        "power_of_timing_description": MessageLookupByLibrary.simpleMessage(
            "Thực hiện thói quen vào cùng một thời điểm mỗi ngày tăng 90% khả năng duy trì."),
        "previous_habits_button":
            MessageLookupByLibrary.simpleMessage("Trang trước đó"),
        "productivity": MessageLookupByLibrary.simpleMessage("Năng suất"),
        "progress_section": MessageLookupByLibrary.simpleMessage("Quá trình"),
        "psy_tab": MessageLookupByLibrary.simpleMessage("Tâm lý"),
        "psychology_cue_routine_reward":
            MessageLookupByLibrary.simpleMessage("Cue-Routine-Reward"),
        "psychology_cue_routine_reward_description":
            MessageLookupByLibrary.simpleMessage(
                "Thói quen được hình thành từ 3 yếu tố: Tín hiệu kích hoạt, Thói quen, và Phần thưởng."),
        "psychology_implementation_intentions":
            MessageLookupByLibrary.simpleMessage("Implementation Intentions"),
        "psychology_implementation_intentions_description":
            MessageLookupByLibrary.simpleMessage(
                "Xác định cụ thể \'khi nào\' và \'ở đâu\' bạn sẽ thực hiện một thói quen có thể tăng tỷ lệ thành công lên 2-3 lần."),
        "quick_stats_title":
            MessageLookupByLibrary.simpleMessage("Các thông số sơ bộ"),
        "quote_aristotle": MessageLookupByLibrary.simpleMessage(
            "Chúng ta là những gì chúng ta làm lặp đi lặp lại. Sự xuất sắc không phải là một hành động mà là một thói quen."),
        "quote_dwayne_johnson": MessageLookupByLibrary.simpleMessage(
            "Thành công không phải là về sự hoàn hảo. Đó là về sự nhất quán."),
        "quote_james_clear": MessageLookupByLibrary.simpleMessage(
            "Thói quen nhỏ tạo nên sự khác biệt lớn."),
        "rate_and_note_completed_habit":
            MessageLookupByLibrary.simpleMessage("Đánh giá và ghi chú"),
        "re_auth_with_email":
            MessageLookupByLibrary.simpleMessage("Xác thực với Email"),
        "re_auth_with_google":
            MessageLookupByLibrary.simpleMessage("Xác thực với Google"),
        "reading_habit_desc": MessageLookupByLibrary.simpleMessage(
            "Nâng cao kiến thức và kỹ năng bằng cách đọc 10 trang sách mỗi ngày."),
        "reading_habit_goal_desc": MessageLookupByLibrary.simpleMessage(
            "Đọc 10 trang sách mỗi ngày để phát triển thói quen học hỏi."),
        "reading_habit_title":
            MessageLookupByLibrary.simpleMessage("Đọc 10 trang sách"),
        "reading_reminder_title":
            MessageLookupByLibrary.simpleMessage("Đến giờ đọc sách rồi"),
        "recovery_description": MessageLookupByLibrary.simpleMessage(
            "Một email đặt lại mật khẩu sẽ được gửi tới email của bạn"),
        "regenerate_button":
            MessageLookupByLibrary.simpleMessage("Tạo thói quen khác"),
        "relevant_accomplish":
            MessageLookupByLibrary.simpleMessage("hoàn thành"),
        "relevant_boost": MessageLookupByLibrary.simpleMessage("tăng cường"),
        "relevant_desc": MessageLookupByLibrary.simpleMessage(
            "Phù hợp với các mục tiêu rộng hơn và tình hình cuộc sống hiện tại của bạn."),
        "relevant_develop": MessageLookupByLibrary.simpleMessage("phát triển"),
        "relevant_enhance": MessageLookupByLibrary.simpleMessage("nâng cao"),
        "relevant_expand": MessageLookupByLibrary.simpleMessage("mở rộng"),
        "relevant_improve": MessageLookupByLibrary.simpleMessage("cải thiện"),
        "relevant_increase": MessageLookupByLibrary.simpleMessage("tăng"),
        "relevant_optimize": MessageLookupByLibrary.simpleMessage("tối ưu hóa"),
        "relevant_raise": MessageLookupByLibrary.simpleMessage("nâng"),
        "relevant_strengthen": MessageLookupByLibrary.simpleMessage("củng cố"),
        "relevant_suggestion_1": MessageLookupByLibrary.simpleMessage(
            "Xem xét tại sao bạn cần đạt được mục đích đó"),
        "relevant_title":
            MessageLookupByLibrary.simpleMessage("Thực tế - Relevant"),
        "reminder_permission_denied": MessageLookupByLibrary.simpleMessage(
            "Không thể thực hiện nhắc nhở nếu không có quyền thông báo"),
        "reminder_permission_request": MessageLookupByLibrary.simpleMessage(
            "Vui lòng cấp thông báo để có thể nhắc nhở thói quen của bạn"),
        "reminder_section": MessageLookupByLibrary.simpleMessage("Nhắc nhở"),
        "remove_water_button": m25,
        "reps_unit": MessageLookupByLibrary.simpleMessage("lần"),
        "reset_password":
            MessageLookupByLibrary.simpleMessage("Đặt lại mật khẩu"),
        "resume_button": MessageLookupByLibrary.simpleMessage("Tiếp tục"),
        "run_habit_desc": MessageLookupByLibrary.simpleMessage(
            "Tăng cường sức khỏe và năng lượng bằng cách đi hoặc chạy bộ 2km mỗi sáng."),
        "run_habit_goal_desc": MessageLookupByLibrary.simpleMessage(
            "Đi hoặc chạy bộ 2km mỗi sáng để cải thiện sức khỏe và thể lực."),
        "run_habit_title":
            MessageLookupByLibrary.simpleMessage("Đi/Chạy bộ 2km"),
        "run_reminder_title":
            MessageLookupByLibrary.simpleMessage("Đến giờ tập chạy"),
        "same_type_habit":
            MessageLookupByLibrary.simpleMessage("Các thói quen cùng loại"),
        "save_button": MessageLookupByLibrary.simpleMessage("Lưu"),
        "science_21_day_rule":
            MessageLookupByLibrary.simpleMessage("Quy tắc 21 ngày"),
        "science_21_day_rule_description": MessageLookupByLibrary.simpleMessage(
            "Nghiên cứu cho thấy thực sự mất 66 ngày để hình thành một thói quen tự động, không phải 21 ngày như nhiều người vẫn nghĩ."),
        "science_dopamine_habits":
            MessageLookupByLibrary.simpleMessage("Dopamine và Thói quen"),
        "science_dopamine_habits_description": MessageLookupByLibrary.simpleMessage(
            "Não tiết ra dopamine không chỉ khi đạt được mục tiêu mà còn khi nhận ra tín hiệu dẫn đến phần thưởng."),
        "science_neuroplasticity":
            MessageLookupByLibrary.simpleMessage("Neuroplasticity"),
        "science_neuroplasticity_description": MessageLookupByLibrary.simpleMessage(
            "Khi bạn lặp lại một hành vi, não tạo ra các kết nối neural mới, làm cho hành vi đó trở nên tự nhiên hơn theo thời gian."),
        "science_tab": MessageLookupByLibrary.simpleMessage("Khoa học"),
        "search_achievement": MessageLookupByLibrary.simpleMessage(
            "Tìm kiếm thành tựu bạn đã đạt được..."),
        "search_community_challenge": MessageLookupByLibrary.simpleMessage(
            "Tìm kiếm những thử thách từ cộng đồng..."),
        "search_my_custom_challenge": MessageLookupByLibrary.simpleMessage(
            "Tìm kiếm những thử thách của tôi..."),
        "searching_title": MessageLookupByLibrary.simpleMessage("Tìm kiếm..."),
        "second_unit": MessageLookupByLibrary.simpleMessage("giây"),
        "select_button": MessageLookupByLibrary.simpleMessage("Chọn"),
        "select_date_title": MessageLookupByLibrary.simpleMessage("Chọn ngày"),
        "select_mood_title":
            MessageLookupByLibrary.simpleMessage("Bạn đang cảm thấy như nào?"),
        "select_range_date_title":
            MessageLookupByLibrary.simpleMessage("Chọn ngày từ ... đến ..."),
        "send_button": MessageLookupByLibrary.simpleMessage("Gửi"),
        "sets_unit": MessageLookupByLibrary.simpleMessage("bộ"),
        "settings": MessageLookupByLibrary.simpleMessage("Cài đặt"),
        "show_all_figure_button":
            MessageLookupByLibrary.simpleMessage("Hiển thị các số liệu"),
        "show_less": MessageLookupByLibrary.simpleMessage("Ẩn bớt"),
        "show_more": MessageLookupByLibrary.simpleMessage("Hiển thị"),
        "smart_criteria_achieved": MessageLookupByLibrary.simpleMessage(
            "Đạt được các tiêu chuẩn SMART"),
        "society_and_family":
            MessageLookupByLibrary.simpleMessage("Xã hội và gia đình"),
        "specific_excellent": MessageLookupByLibrary.simpleMessage(
            "Mục tiêu của bạn rất rõ ràng và được xác định cụ thể"),
        "specific_good": MessageLookupByLibrary.simpleMessage(
            "Mục tiêu của bạn khá cụ thể nhưng có thể cần thêm chi tiết"),
        "specific_needs_work": MessageLookupByLibrary.simpleMessage(
            "Mục tiêu cần thêm chi tiết cụ thể về những gì bạn muốn đạt được"),
        "specific_poor": MessageLookupByLibrary.simpleMessage(
            "Mục tiêu quá mơ hồ và cần hành động cụ thể"),
        "specific_suggestion_1": MessageLookupByLibrary.simpleMessage(
            "Thêm số liệu hoặc số lượng cụ thể để đo lường thành công"),
        "specific_suggestion_2": MessageLookupByLibrary.simpleMessage(
            "Thêm động từ hành động rõ ràng mô tả những gì bạn sẽ làm"),
        "specific_suggestion_3": MessageLookupByLibrary.simpleMessage(
            "Xác định chính xác những gì bạn muốn đạt được"),
        "specify_desc": MessageLookupByLibrary.simpleMessage(
            "Mục tiêu rõ ràng và cụ thể, trả lời được các câu hỏi ai, cái gì, ở đâu, khi nào và tại sao."),
        "specify_title":
            MessageLookupByLibrary.simpleMessage("Cụ thể - Specify"),
        "start_date": MessageLookupByLibrary.simpleMessage("Ngày bắt đầu"),
        "start_tracking":
            MessageLookupByLibrary.simpleMessage("Bắt đầu theo dõi"),
        "start_value_must_be_less_than_end":
            MessageLookupByLibrary.simpleMessage(
                "Giá trị bắt đầu phải nhỏ hơn giá trị kết thúc"),
        "statistic_info_tab": MessageLookupByLibrary.simpleMessage("Thống kê"),
        "statistic_section": MessageLookupByLibrary.simpleMessage("Thống kê"),
        "statistics_habit_formation_time":
            MessageLookupByLibrary.simpleMessage("Thời gian hình thành"),
        "statistics_habit_formation_time_description":
            MessageLookupByLibrary.simpleMessage(
                "Thời gian hình thành thói quen có thể dao động từ 18 đến 254 ngày tùy thuộc vào độ phức tạp."),
        "statistics_success_rate":
            MessageLookupByLibrary.simpleMessage("Tỷ lệ thành công"),
        "statistics_success_rate_description": MessageLookupByLibrary.simpleMessage(
            "43% hành động hàng ngày của chúng ta được thực hiện một cách vô thức do thói quen."),
        "status_achieved": MessageLookupByLibrary.simpleMessage("Đạt được"),
        "status_completed": MessageLookupByLibrary.simpleMessage("Hoàn thành"),
        "status_failed": MessageLookupByLibrary.simpleMessage("Thất bại"),
        "status_in_progress":
            MessageLookupByLibrary.simpleMessage("Đang thực hiện"),
        "status_locked": MessageLookupByLibrary.simpleMessage("Chưa mở khóa"),
        "status_paused": MessageLookupByLibrary.simpleMessage("Tạm dừng"),
        "status_pending": MessageLookupByLibrary.simpleMessage("Chờ xử lý"),
        "status_skipped": MessageLookupByLibrary.simpleMessage("Bỏ qua"),
        "status_title": MessageLookupByLibrary.simpleMessage("Trạng thái"),
        "status_unknown":
            MessageLookupByLibrary.simpleMessage("Không xác định"),
        "status_unlocked": MessageLookupByLibrary.simpleMessage("Đã mở khóa"),
        "steps_unit": MessageLookupByLibrary.simpleMessage("bước"),
        "stop_button": MessageLookupByLibrary.simpleMessage("Dừng"),
        "stop_tracking": MessageLookupByLibrary.simpleMessage("Dừng theo dõi"),
        "stop_tracking_confirm": MessageLookupByLibrary.simpleMessage(
            "Bạn muốn dừng hay tiếp tục theo dõi?"),
        "streak_long_100": MessageLookupByLibrary.simpleMessage(
            "Tuyệt vời! Bạn đã giữ vững streak 100 ngày không gián đoạn!"),
        "streak_long_40": MessageLookupByLibrary.simpleMessage(
            "Kinh ngạc! Bạn đã duy trì thói quen liên tiếp 40 ngày!"),
        "streak_long_60": MessageLookupByLibrary.simpleMessage(
            "Thật không thể tin nổi! Bạn đã đạt được 60 ngày streak!"),
        "streak_medium_10": MessageLookupByLibrary.simpleMessage(
            "Tuyệt vời! Bạn đã duy trì được 10 ngày không gián đoạn!"),
        "streak_medium_15": MessageLookupByLibrary.simpleMessage(
            "Không ngừng nỗ lực! Bạn đã đạt được 15 ngày liên tục!"),
        "streak_medium_30": MessageLookupByLibrary.simpleMessage(
            "Bạn thật tuyệt! Đã duy trì 30 ngày kiên trì và đều đặn!"),
        "streak_short_0": MessageLookupByLibrary.simpleMessage(
            "Bắt đầu nào! Bạn đã bắt đầu thói quen mới!"),
        "streak_short_1": MessageLookupByLibrary.simpleMessage(
            "Khởi đầu tuyệt vời! Bạn đã đạt được 1 ngày không bỏ lỡ!"),
        "streak_short_3": MessageLookupByLibrary.simpleMessage(
            "Cố lên! Bạn đã duy trì được 3 ngày liên tiếp rồi!"),
        "streak_short_7": MessageLookupByLibrary.simpleMessage(
            "Xuất sắc! Bạn đã hoàn thành 7 ngày liên tiếp!"),
        "streak_very_long_150": MessageLookupByLibrary.simpleMessage(
            "Không thể tin được! Bạn đã duy trì thói quen suốt 150 ngày!"),
        "streak_very_long_200": MessageLookupByLibrary.simpleMessage(
            "Đáng khâm phục! Bạn đã giữ streak 200 ngày liên tiếp!"),
        "streak_very_long_365": MessageLookupByLibrary.simpleMessage(
            "Bạn là người hùng! Đã đạt được 365 ngày không bỏ lỡ!"),
        "study_habit_desc": MessageLookupByLibrary.simpleMessage(
            "Nâng cao hiệu quả học tập bằng cách tập trung học trong 2 tiếng vào buổi tối."),
        "study_habit_goal_desc": MessageLookupByLibrary.simpleMessage(
            "Học tập tập trung trong 2 tiếng mỗi tối vào lúc 7h tối mỗi ngày để cải thiện kiến thức."),
        "study_habit_title":
            MessageLookupByLibrary.simpleMessage("Học tập tập trung 2 tiếng"),
        "study_reminder_title":
            MessageLookupByLibrary.simpleMessage("Đến giờ học"),
        "success_title": MessageLookupByLibrary.simpleMessage("Thành công"),
        "summary_excellent": MessageLookupByLibrary.simpleMessage(
            "Mục tiêu SMART xuất sắc! Tất cả tiêu chí đều được xác định rõ ràng và cân đối."),
        "summary_good": m26,
        "summary_needs_work": m27,
        "summary_poor": m28,
        "summary_title": MessageLookupByLibrary.simpleMessage("Tổng hợp"),
        "target_title": MessageLookupByLibrary.simpleMessage("Mục tiêu"),
        "term_and_condition_statement": MessageLookupByLibrary.simpleMessage(
            "Bằng cách đăng nhập/đăng ký, bạn chấp nhận Điều khoản và Điều kiện của chúng tôi và đồng ý với Chính sách Quyền riêng tư"),
        "terms_and_conditions":
            MessageLookupByLibrary.simpleMessage("Điều khoản & Điều kiện"),
        "terrible_suggestion_1":
            MessageLookupByLibrary.simpleMessage("Nên nỗ lực nhiều hơn"),
        "terrible_suggestion_2": MessageLookupByLibrary.simpleMessage(
            "Cần cải thiện nhiều hơn nữa!"),
        "theme_tile": MessageLookupByLibrary.simpleMessage("Giao diện"),
        "time_based_progress":
            MessageLookupByLibrary.simpleMessage("Quá trình theo thời gian"),
        "time_bound_achieve": MessageLookupByLibrary.simpleMessage("đạt được"),
        "time_bound_after": MessageLookupByLibrary.simpleMessage("sau"),
        "time_bound_before": MessageLookupByLibrary.simpleMessage("trước"),
        "time_bound_by": MessageLookupByLibrary.simpleMessage("trước"),
        "time_bound_complete":
            MessageLookupByLibrary.simpleMessage("hoàn thành"),
        "time_bound_complete_by":
            MessageLookupByLibrary.simpleMessage("hoàn thành bởi"),
        "time_bound_deadline": MessageLookupByLibrary.simpleMessage("thời hạn"),
        "time_bound_desc": MessageLookupByLibrary.simpleMessage(
            "Có thời hạn hoặc khung thời gian rõ ràng để hoàn thành."),
        "time_bound_due": MessageLookupByLibrary.simpleMessage("đến hạn"),
        "time_bound_duration":
            MessageLookupByLibrary.simpleMessage("khoảng thời gian"),
        "time_bound_end": MessageLookupByLibrary.simpleMessage("kết thúc"),
        "time_bound_end_by":
            MessageLookupByLibrary.simpleMessage("kết thúc bởi"),
        "time_bound_end_date":
            MessageLookupByLibrary.simpleMessage("ngày kết thúc"),
        "time_bound_finalize": MessageLookupByLibrary.simpleMessage("hoàn tất"),
        "time_bound_finish": MessageLookupByLibrary.simpleMessage("kết thúc"),
        "time_bound_goal": MessageLookupByLibrary.simpleMessage("mục tiêu"),
        "time_bound_immediate":
            MessageLookupByLibrary.simpleMessage("ngay lập tức"),
        "time_bound_in_the_next":
            MessageLookupByLibrary.simpleMessage("trong vòng"),
        "time_bound_in_time": MessageLookupByLibrary.simpleMessage("kịp thời"),
        "time_bound_next": MessageLookupByLibrary.simpleMessage("tiếp theo"),
        "time_bound_on": MessageLookupByLibrary.simpleMessage("vào"),
        "time_bound_post": MessageLookupByLibrary.simpleMessage("sau"),
        "time_bound_promptly":
            MessageLookupByLibrary.simpleMessage("ngay tức thì"),
        "time_bound_quickly":
            MessageLookupByLibrary.simpleMessage("nhanh chóng"),
        "time_bound_reach": MessageLookupByLibrary.simpleMessage("đạt đến"),
        "time_bound_scheduled": MessageLookupByLibrary.simpleMessage("dự kiến"),
        "time_bound_set_date": MessageLookupByLibrary.simpleMessage("đặt ngày"),
        "time_bound_soon": MessageLookupByLibrary.simpleMessage("sớm"),
        "time_bound_soon_after":
            MessageLookupByLibrary.simpleMessage("ngay sau khi"),
        "time_bound_start": MessageLookupByLibrary.simpleMessage("bắt đầu"),
        "time_bound_start_by":
            MessageLookupByLibrary.simpleMessage("bắt đầu bởi"),
        "time_bound_start_from":
            MessageLookupByLibrary.simpleMessage("bắt đầu từ"),
        "time_bound_time_limit":
            MessageLookupByLibrary.simpleMessage("giới hạn thời gian"),
        "time_bound_timeframe":
            MessageLookupByLibrary.simpleMessage("khung thời gian"),
        "time_bound_timely": MessageLookupByLibrary.simpleMessage("kịp thời"),
        "time_bound_title":
            MessageLookupByLibrary.simpleMessage("Thời gian - TimeBound"),
        "time_bound_until": MessageLookupByLibrary.simpleMessage("đến khi"),
        "time_bound_upon_completion":
            MessageLookupByLibrary.simpleMessage("sau khi hoàn thành"),
        "time_bound_urgent": MessageLookupByLibrary.simpleMessage("khẩn cấp"),
        "time_bound_within": MessageLookupByLibrary.simpleMessage("trong vòng"),
        "time_bound_within_the_next":
            MessageLookupByLibrary.simpleMessage("trong vòng"),
        "time_interval":
            MessageLookupByLibrary.simpleMessage("Các khoảng thời gian"),
        "time_of_day_section":
            MessageLookupByLibrary.simpleMessage("Thời gian trong ngày"),
        "time_slot_heatmap": MessageLookupByLibrary.simpleMessage(
            "Biểu đồ thời gian trong ngày"),
        "time_tracker": MessageLookupByLibrary.simpleMessage("Bộ đếm theo dõi"),
        "times_unit": MessageLookupByLibrary.simpleMessage("lần"),
        "today": MessageLookupByLibrary.simpleMessage("Hôm nay"),
        "today_tasks": MessageLookupByLibrary.simpleMessage("Nhiệm vụ hôm nay"),
        "total": m29,
        "total_achievement": m30,
        "total_distance":
            MessageLookupByLibrary.simpleMessage("Tổng quãng đường"),
        "total_habit":
            MessageLookupByLibrary.simpleMessage("Tất cả các thói quen"),
        "total_paused_time":
            MessageLookupByLibrary.simpleMessage("Tổng số thời gian tạm ngưng"),
        "total_streak": m31,
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
        "water_habit_desc": MessageLookupByLibrary.simpleMessage(
            "Giữ cơ thể luôn đủ nước và cải thiện sức khỏe tổng thể bằng cách uống 2 lít nước mỗi ngày"),
        "water_habit_goal_desc": MessageLookupByLibrary.simpleMessage(
            "Uống 2 lít nước mỗi ngày trong 30 ngày tới để giữ cơ thể luôn đủ nước và duy trì sức khỏe tốt"),
        "water_habit_title":
            MessageLookupByLibrary.simpleMessage("Uống đủ 2L nước mỗi ngày"),
        "water_reminder_title":
            MessageLookupByLibrary.simpleMessage("Đến lúc uống nước"),
        "weak_password": MessageLookupByLibrary.simpleMessage(
            "Vui lòng nhập mật khẩu mạnh hơn."),
        "weekday_title":
            MessageLookupByLibrary.simpleMessage("Các ngày trong tuần"),
        "weekly_completion_rate":
            MessageLookupByLibrary.simpleMessage("Tỉ lệ hoàn thành theo tuần"),
        "weekly_mood":
            MessageLookupByLibrary.simpleMessage("Tâm trạng trong tuần"),
        "weekly_process_section":
            MessageLookupByLibrary.simpleMessage("Hằng tuần"),
        "wrong_password": MessageLookupByLibrary.simpleMessage(
            "Mật khẩu không chính xác, vui lòng thử lại."),
        "year_title": MessageLookupByLibrary.simpleMessage("Năm"),
        "you_achieved": m32
      };
}
