class GuideDetails {
  int ID;
  String job;
  String experience;
  String company;
  String about;
  String qualification;
  String name;
  String email;
  String phone;
  String url;
  String type;

  GuideDetails ({
    this.job,
    this.experience,
    this.company,
    this.about,
    this.qualification,
    this.ID,
    this.name,
    this.email,
    this.phone,
    this.url,
    this.type
  });

  factory GuideDetails.fromJson(Map<String, dynamic> item) {
    return GuideDetails(
        url: item['url'],
        ID: item['id'],
        name: item['name'],
        phone: item['phone'],
        email: item['email'],
        type: item['type'],
        qualification: item['qualification'],
        job: item['job'],
        about: item['about'],
        experience: item['experience'],
        company: item['company'],
    );
  }
}