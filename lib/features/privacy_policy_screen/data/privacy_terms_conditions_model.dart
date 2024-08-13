class PrivacyTermsModel {
  final PrivacyPolicy? privacyPolicy;
  final TermsConditions? termsConditions;

  PrivacyTermsModel({
    this.privacyPolicy,
    this.termsConditions,
  });

  PrivacyTermsModel.fromJson(Map<String, dynamic> json)
      : privacyPolicy =
            (json['privacy_policy'] as Map<String, dynamic>?) != null
                ? PrivacyPolicy.fromJson(
                    json['privacy_policy'] as Map<String, dynamic>)
                : null,
        termsConditions =
            (json['terms_conditions'] as Map<String, dynamic>?) != null
                ? TermsConditions.fromJson(
                    json['terms_conditions'] as Map<String, dynamic>)
                : null;

  Map<String, dynamic> toJson() => {
        'privacy_policy': privacyPolicy?.toJson(),
        'terms_conditions': termsConditions?.toJson()
      };
}

class PrivacyPolicy {
  final Description? description;

  PrivacyPolicy({
    this.description,
  });

  PrivacyPolicy.fromJson(Map<String, dynamic> json)
      : description = (json['description'] as Map<String, dynamic>?) != null
            ? Description.fromJson(json['description'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {'description': description?.toJson()};
}

class Description {
  final String? title;
  final String? description;

  Description({
    this.title,
    this.description,
  });

  Description.fromJson(Map<String, dynamic> json)
      : title = json['title'] as String?,
        description = json['description'] as String?;

  Map<String, dynamic> toJson() => {'title': title, 'description': description};
}

class TermsConditions {
  final Description? description;

  TermsConditions({
    this.description,
  });

  TermsConditions.fromJson(Map<String, dynamic> json)
      : description = (json['description'] as Map<String, dynamic>?) != null
            ? Description.fromJson(json['description'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {'description': description?.toJson()};
}
