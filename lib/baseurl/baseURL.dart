class BaseuURL {
//  static var apibaseUrl = 'http://sanjaytesting.info/API/';
  static var apibaseUrl = 'https://trendychikitsa.com/api/';
static var profileURL="https://cerbosys.in:1700/doctorprofile/";
  static var categoryURL="https://cerbosys.in:1700/category/";
  static var dummy_token =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEiLCJ1c2VyX2lkIjoiOTIyMTgwIiwicmVmZXJyYWxfY29kZSI6Ik9DRTAwMDAxIiwibmFtZSI6IlN1cHBvcnQiLCJlbWFpbCI6InN1cHBvcnRAb25lY2xpY2suY29tIiwibW9iaWxlX25vIjoiMzQ1Njc4OTAzOCIsInBpYyI6Imh0dHBzOlwvXC9vbmVjbGlja2Vhcm4uaW5cL09uZUNsaWNrXC8iLCJBUElfVElNRSI6MTYyODMzNDQ3MX0.MtQlNvaNlhLtkddnyvnD_YdNhRLH0SPO5ihJ4Qf44-c';
  static var getAllDoctorCategories = Uri.parse('${apibaseUrl}getAllDoctorCategories/');
  static var loginUser = Uri.parse('${apibaseUrl}login_user/');
  static var updateUserName = Uri.parse('${apibaseUrl}updateUser/');
  static var updatePricing = Uri.parse('${apibaseUrl}update_pricing/');
  static var submitExperties = Uri.parse('${apibaseUrl}submit_expertise/');
  static var socialMediaHealer = Uri.parse('${apibaseUrl}social_media_healer/');
  static var healer_social_media = Uri.parse('${apibaseUrl}healer_social_media/');
  static var healer_therapy_pricing = Uri.parse('${apibaseUrl}healer_therapy_pricing/');
  static var book_appointment = Uri.parse('${apibaseUrl}book_appointment/');


  static var addTimeSlot = Uri.parse('${apibaseUrl}add_time_slot/');
  static var register_user =
  Uri.parse('${apibaseUrl}register_user/');

  static var healer_change_password = Uri.parse('${apibaseUrl}healer_change_password/');


  static var scheduleTimeListing =
      Uri.parse('${apibaseUrl}schedule_time_listing/');

  static var delete_time_slot =
  Uri.parse('${apibaseUrl}delete_time_slot/');
  static var top_featured_healer =
  Uri.parse('${apibaseUrl}top_featured_healer/');

  static var top_reviewed_healer =
  Uri.parse('${apibaseUrl}top_reviewed_healer/');

  static var allTherapies =
  Uri.parse('${apibaseUrl}all_therapies/');
  static var healerByTherapy =
  Uri.parse('${apibaseUrl}healers_bytherapy/');
  static var healerProfile =
  Uri.parse('${apibaseUrl}healer_profile/');
  static var clientChangePassword =
  Uri.parse('${apibaseUrl}client_change_password/');

  static var client_appointment =
  Uri.parse('${apibaseUrl}client_appointment/');

  static var healer_appointment =
  Uri.parse('${apibaseUrl}healer_appointment/');

  static var healerprofile_detail =
  Uri.parse('${apibaseUrl}healerprofile_detail/');

}
