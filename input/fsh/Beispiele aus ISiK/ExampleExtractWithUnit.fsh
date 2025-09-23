Instance: ExampleExtractWithUnit
InstanceOf: ISiKFormularDefinition

* insert QuestionnaireExamplesMetadata(ExampleExtractWithUnit)
* title = "Observation Based Extraction bei quantitativen Angaben"
* description = "### Beispiel-Questionnaire mit Observation Based Extraction von Dezimalwerten mit Maßeinheiten  
  * Vorgabe der anzugebenden Maßeinheit mittels [questionnaire-unit](https://hl7.org/fhir/R4/extension-questionnaire-unit.html)-Extension
  * Annotation zur Extraktion mittels [observationExtract](http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-observationExtract)
  * Annotation zum Setzen der category bei Extraktion mittels [observationExtractCategory](http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-observationExtract-category)"
* item[+]
  * type = #group
  * required = false
  * linkId = "4"
  * text = "Körpermaße"
  * item[+]  
    //Annotation mit codierter Maßeinheit
    * insert uunit(kg)
    * code = $loinc#29463-7
    * linkId = "4.1"
    * text = "Körpergewicht in kg"
    * type = #decimal
    * insert observationExtract
    * insert observationExtractCategoryVitalSign
  * item[+]  
    //Annotation mit codierter Maßeinheit
    * insert uunit(cm)
    * code = $loinc#8302-2
    * linkId = "4.2"
    * text = "Körpergröße in cm"
    * type = #decimal
    * insert observationExtract
    * insert observationExtractCategoryVitalSign