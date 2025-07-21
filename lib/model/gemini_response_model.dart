class GeminiResponseModel {
  final List<Candidate> candidates;
  final UsageMetadata usageMetadata;
  final String modelVersion;
  final String responseId;

  GeminiResponseModel({
    required this.candidates,
    required this.usageMetadata,
    required this.modelVersion,
    required this.responseId,
  });

  factory GeminiResponseModel.fromJson(Map<String, dynamic> json) {
    return GeminiResponseModel(
      candidates: (json['candidates'] as List)
          .map((e) => Candidate.fromJson(e))
          .toList(),
      usageMetadata: UsageMetadata.fromJson(json['usageMetadata']),
      modelVersion: json['modelVersion'],
      responseId: json['responseId'],
    );
  }
}

class Candidate {
  final Content content;
  final String finishReason;
  final double avgLogprobs;

  Candidate({
    required this.content,
    required this.finishReason,
    required this.avgLogprobs,
  });

  factory Candidate.fromJson(Map<String, dynamic> json) {
    return Candidate(
      content: Content.fromJson(json['content']),
      finishReason: json['finishReason'],
      avgLogprobs: (json['avgLogprobs'] ?? 0).toDouble(),
    );
  }
}

class Content {
  final List<Part> parts;
  final String role;

  Content({
    required this.parts,
    required this.role,
  });

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      parts: (json['parts'] as List)
          .map((e) => Part.fromJson(e))
          .toList(),
      role: json['role'],
    );
  }
}

class Part {
  final String text;

  Part({required this.text});

  factory Part.fromJson(Map<String, dynamic> json) {
    return Part(
      text: json['text'] ?? '',
    );
  }
}

class UsageMetadata {
  final int promptTokenCount;
  final int candidatesTokenCount;
  final int totalTokenCount;
  final List<TokenDetail> promptTokensDetails;
  final List<TokenDetail> candidatesTokensDetails;

  UsageMetadata({
    required this.promptTokenCount,
    required this.candidatesTokenCount,
    required this.totalTokenCount,
    required this.promptTokensDetails,
    required this.candidatesTokensDetails,
  });

  factory UsageMetadata.fromJson(Map<String, dynamic> json) {
    return UsageMetadata(
      promptTokenCount: json['promptTokenCount'],
      candidatesTokenCount: json['candidatesTokenCount'],
      totalTokenCount: json['totalTokenCount'],
      promptTokensDetails: (json['promptTokensDetails'] as List)
          .map((e) => TokenDetail.fromJson(e))
          .toList(),
      candidatesTokensDetails: (json['candidatesTokensDetails'] as List)
          .map((e) => TokenDetail.fromJson(e))
          .toList(),
    );
  }
}

class TokenDetail {
  final String modality;
  final int tokenCount;

  TokenDetail({
    required this.modality,
    required this.tokenCount,
  });

  factory TokenDetail.fromJson(Map<String, dynamic> json) {
    return TokenDetail(
      modality: json['modality'],
      tokenCount: json['tokenCount'],
    );
  }
}
