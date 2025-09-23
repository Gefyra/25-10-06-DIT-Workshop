Alias: $sdc-questionnaire-itemMedia = http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-itemMedia
Alias: $sdc-questionnaire-itemAnswerMedia = http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-itemAnswerMedia
Alias: $ordinalValue = http://hl7.org/fhir/StructureDefinition/ordinalValue

Profile: ISiKFormularDaten
Parent: QuestionnaireResponse
Title: "Ausgefülltes ISiK-Formular"
Description: "ToDo"
* obeys sdcqr-1 and sdcqr-2
* modifierExtension contains
  ISiKMDRRelevanzFormularExtension named MDR-Relevant 0..1 MS
* modifierExtension[MDR-Relevant]
  * ^short = "MPG-Relevanz der Formulardaten"
  * ^comment = "**Begründung MS:**
  In dieser Extension wird angegeben, dass die Formulardaten MDR-relevant sind. Für die Erhebung und/oder Darstellung müssen ggf. bestimmte Voraussetzungen erfüllt sein. Ist die Extension nicht vorhanden, liegt keine MDR-relevanmt vor."  
* modifierExtension[MDR-Relevant].valueCoding MS
* identifier MS
  * ^short = "eindeutiger Identifier der FormularDaten"
  * ^comment = "**Begründung MS:**
  Ein vom FormularRenderer vergebener, eindeutiger Identifier kann von weiterverarbeitenden Systemen genutzt werden, um Dubletten zu erkennen."
* questionnaire 1.. MS
  * ^short = "Bezug zur FormularDefinition inkl. Version"
  * ^comment = "Bei der Angabe der Canonical, sollte die Version der FormularDefinition, welche bei der Erstellung die Grundlage gebildet hat, angegeben sein.
  **Begründung MS:** 
  Der Bezug zur Formulardefinition kann für die Interpretation und Darstellung der Formulardaten relevant sein."
//* questionnaire only Canonical(ISiKFormularDefinition) 
  * extension contains DisplayName named questionnaireDisplay 1..1 MS
  * extension[questionnaireDisplay] 
    * ^short = "Titel/Überschrift der zugrunde liegenden FormularDefinition"
    * ^comment = "Wird für die Darstellung und Auffindbarkeit der FormularDaten benötigt."
* status MS
  * ^short = "Status"
  * ^comment = "**Begründung Pflichtfeld:**
  Bei der Verarbeitung von FormularDaten ist es wichtig, den Status zu beachten. Falls die Instanz noch nicht `completed` ist, sollte von einer Weiterverarbeitung abgesehen werden."
* subject 1..1 MS
  * ^short = "Subject (Patient), über das in diesem Formular berichtet wird."
  * ^comment = "**Begründung Pflichtfeld:**  
  Zur Vereinfachung des Workflows werden zunächst nur Formulare mit Patientenbezug zugelassen.  
  Diese Anforderung kann in künftigen Ausbaustufen gelockert werden."
* authored 1.. MS
  * ^short = "Datum der FormularDaten"
  * ^comment = "**Begründung Pflichtfeld:** 
  Relevant für die Suche und zeitliche Einordnung der FormularDaten"
* author MS
  * ^short = "Ersteller des Fromulars"
  * ^comment = "Auch wenn hier keine Einschränkung vorgenommen wurde, ist zu empfehlen, hier die ausfüllende Person (Patient/Practitioner) zu referenzieren und nicht nur die Software (Device), mit der das Formular ausgefüllt wurde.
  **Begründung MS:**
  In den meisten Fällen ist relevant, wer Formulardaten erfasst hat."
* item MS
  * linkId MS
    * ^short = "Eindeutige ID des Formularelement"
    * ^comment = "**Begründung Pflichtfeld:**
    Die LinkId ordnet die Information der Antwort einer Frage in der FormularDefinition zu und ist aus dem Grund zur Interpretation der Antwort unablässig."
  * text MS
    * ^short = "Frage, die beantwortet wurde"
    * ^comment = "**Begründung Pflichtfeld:**  
    Die FormularDaten sollte pro Antwort auch die Fragestellung mitführen, 
    damit die Daten auch von Systemen/Anwendern interpretiert werden können, 
    die *keinen* Zugriff auf die zugrunde liegende FormularDefinition haben."
  * answer MS
    * ^short = "Antwort"
    * ^comment = "**Begründung MS:**
    Die erfasste Antwort MUSS stets vorhanden sein."
    * value[x] MS
      * ^short = "Inhalt der Antwort"
      * ^comment = "**Begründung MS:**
      Der Inhalt der jeweilig erfassten Antwort MUSS stehts vorhanden sein."
    * item MS
      * ^short = "Untergeordnetes Item"
      * ^comment = "**Begründung MS:**  
   Items können beliebig verschachtelt und zu Gruppen zusammengefasst werden, um komplexere und umfangreichere Formulare zu strukturieren."
  * item MS
    * ^short = "Untergeordnetes Item"
    * ^comment = "**Begründung MS:**  
   Items können beliebig verschachtelt und zu Gruppen zusammengefasst werden, um komplexere und umfangreichere Formulare zu strukturieren."



Invariant: sdcqr-1
Description: "Subject SHOULD be present (searching is difficult without subject).  Almost all QuestionnaireResponses should be with respect to some sort of subject."
* severity = #warning
* expression = "subject.exists()"
* xpath = "exists(f:subject)"
* extension[0].url = "http://hl7.org/fhir/StructureDefinition/elementdefinition-bestpractice"
* extension[0].valueBoolean = true

Invariant: sdcqr-2
Description: "When repeats=true for a group, it'll be represented with multiple items with the same linkId in the QuestionnaireResponse.  For a question, it'll be represented by a single item with that linkId with multiple answers."
* severity = #error
* expression = "(QuestionnaireResponse|repeat(answer|item)).select(item.where(answer.value.exists()).linkId.isDistinct()).allTrue()"
* xpath = "not(exists(for $item in descendant::f:item[f:answer] return $item/preceding-sibling::f:item[f:linkId/@value=$item/f:linkId/@value]))"
* extension[0].url = "http://hl7.org/fhir/StructureDefinition/elementdefinition-bestpractice"
* extension[0].valueBoolean = true