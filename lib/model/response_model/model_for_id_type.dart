

import 'dart:convert';

DocumentTypeResponse documentTypeResponseFromJson(String str) => DocumentTypeResponse.fromJson(json.decode(str));

String documentTypeResponseToJson(DocumentTypeResponse data) => json.encode(data.toJson());

class DocumentTypeResponse {
    List<Document>? documents;

    DocumentTypeResponse({
         this.documents,
    });

    factory DocumentTypeResponse.fromJson(Map<String, dynamic> json) => DocumentTypeResponse(
        documents: List<Document>.from(json["documents"].map((x) => Document.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "documents": List<dynamic>.from(documents!.map((x) => x.toJson())),
    };
}

class Document {
    String? id;
    String? name;
    String? type;
    String? url;

    Document({
         this.id,
         this.name,
         this.type,
         this.url,
    });

    factory Document.fromJson(Map<String, dynamic> json) => Document(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "url": url,
    };
}
