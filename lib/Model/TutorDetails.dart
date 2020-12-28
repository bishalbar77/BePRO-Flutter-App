class TutorDetails {
  int ID;
  String title;
  String address;
  String skills;
  String job;
  String qualification;
  String company;
  String fees;
  String upi;
  String name;
  String email;
  String phone;
  String url;
  String type;

  TutorDetails ({
    this.title,
    this.address,
    this.skills,
    this.job,
    this.qualification,
    this.fees,
    this.company,
    this.upi,
    this.ID,
    this.name,
    this.email,
    this.phone,
    this.url,
    this.type
  });

  factory TutorDetails.fromJson(Map<String, dynamic> item) {
    return TutorDetails(
      url: item['url'],
      ID: item['id'],
      name: item['name'],
      phone: item['phone'],
      email: item['email'],
      type: item['type'],
      qualification: item['qualification'],
      job: item['job'],
      title: item['title'],
      fees: item['fees'],
      company: item['company'],
      address: item['address'],
      upi: item['upi'],
      skills: item['skills'],
    );
  }
}