package ifml.generator.ng2.m2t.dynamic.app.context;

import ifml.generator.ng2.m2t.general.AbstractFileGenerator
import java.util.LinkedList
import org.w3c.dom.Node

class ContextEntityGenerator extends AbstractFileGenerator<Node> {

	
// Overridden Parent methods
	override protected fileContents(Node entity) {
		var entityName = entity.attributes.getNamedItem("name").nodeValue;
		
		//extract the properties of the entity
		var properties = entity.childNodes;
		var propertyList = new LinkedList;				
		for(var i = 0; i < properties.length; i++){
			var property = properties.item(i).attributes;
			propertyList.add(property);
		}
		
		//extract the needed imports for types
		var typeList = new LinkedList;		
		for(prop: propertyList){
			var propType = prop.getNamedItem("type").nodeValue.toFirstUpper;
			if(propType != "String" && propType != "Number" && propType != "Boolean" && !typeList.contains(propType)){
				typeList.add(propType);
			}
		}
		
				
		'''
			// «entityName.toFirstLower» context
			
			«FOR type: typeList»
				import { «type» } from '../types/«type»';
			«ENDFOR»
			
			export class «entityName.toFirstUpper»Profile {
				
			«FOR prop: propertyList»
				«var propName = prop.getNamedItem("name").nodeValue.toFirstLower»
				«var propType = prop.getNamedItem("type").nodeValue.toFirstUpper»
					private «propName»: «
						if(propType == "String" || propType == "Number" || propType == "Boolean"){
							propType.toFirstLower
						}else{
							propType
						}»;
			«ENDFOR»
			    
			    constructor(){};
			    
			«FOR prop: propertyList»
				«var propName = prop.getNamedItem("name").nodeValue.toFirstLower»
				«var propType = prop.getNamedItem("type").nodeValue.toFirstUpper»
					public set«propName.toFirstUpper»(v: «
						if(propType == "String" || propType == "Number" || propType == "Boolean"){
							propType.toFirstLower
						}else{
							propType
						}»){
					    this.«propName» = v;
					};
					
					public get«propName.toFirstUpper»(): «
						if(propType == "String" || propType == "Number" || propType == "Boolean"){
							propType.toFirstLower
						}else{
							propType
						}»{
					    return this.«propName»;
					}
			«ENDFOR»
			}

		'''
	}
	
	override protected fileName(Node entity) {
		var entityName = entity.attributes.getNamedItem("name").nodeValue;
		
		'''«entityName.toFirstLower».profile.ts'''
	}
	
	override protected folderName(Node entity) {
		'''app/context/profile/'''
	}
}