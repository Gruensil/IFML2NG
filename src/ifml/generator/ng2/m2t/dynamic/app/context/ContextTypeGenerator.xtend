package ifml.generator.ng2.m2t.dynamic.app.context;

import ifml.generator.ng2.m2t.general.AbstractFileGenerator
import java.util.LinkedList
import org.w3c.dom.Node

class ContextTypeGenerator extends AbstractFileGenerator<Node> {

	
// Overridden Parent methods
	override protected fileContents(Node type) {
		
		var typeName = type.attributes.getNamedItem("name").nodeValue
		var enums = new LinkedList;
		
		for(var i = 0; i < type.childNodes.length; i++){
			enums.add(type.childNodes.item(i).attributes.getNamedItem("name").nodeValue)
		}
		
		'''
			//Generated by ContextTypeGenerator
			
			//contains a user-defined Type
			
			export enum «typeName.toFirstUpper»{
				«var j = 0»
				«FOR enu: enums»
					«enu.toFirstLower» = «j++»,
			    «ENDFOR»
			}
		'''
	}
	
	override protected fileName(Node type) {		
		var typeName = type.attributes.getNamedItem("name").nodeValue
		
		'''«typeName.toFirstUpper».ts'''
	}
	
	override protected folderName(Node type) {
		'''app/context/types/'''
	}
}