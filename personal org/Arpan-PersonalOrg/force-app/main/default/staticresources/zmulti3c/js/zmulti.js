/**
 * Original Code by Timbabox - #
 *
 * -Upload content into Salesforce on one click.
 * -Drag and drop files onto your browser.
 * -Upload multiple files at once.
 * -Upload any type of file.
 * -Help your organization save time.
 * @Author: Martin Prado - mprado@timbasoftware.com
 * @Author: Mathias Moller - mmoller@timbasoftware.com
 */


TimbaBoxes = function($){
	var model = {
			errors : {
					error : '',
					errorArr : '',
					errorQuery : '',
					addresError : "",
					merror : 'upload failed',
					errorMail : false
			},
			attachments : {
	                findResult : null,
	                resultAttachmen : null,
	                files : null,
	                currentFileIndex : 0
	        },
	        email : {
	                msgFieldEmpty : "An email address is required.",
	                addres : new Array(),
	                addresInput:'',
	                valid:false
       		}
	};
	
				
	var view = {
		    
		    /*
	         * Hide all divs 
	  		 */
			hideAllDivs : function(){  
							$(".timbaBox").css("display", "none");      
			}, 
			
	        /*
	         *  showDiv
			 *  @param  string Div Id
		     */
			showDiv : function(DivId){
							$("#"+ DivId).css("display", "");
			},
			
			/*
		 	* Create Html
		 	* Generate the hmtl for the boxes
		 	*/
			createHTML : function(){
							var pic1 = document.getElementsByClassName('pic1')[0].src,
							    pic2 = document.getElementsByClassName('pic2')[0].src;
							code = '<div class="timbaBox" id="output">';
							code += 	'<div id="timbaBox_content">';
							code +=			'<div class="content_generated"><div class="headerImg"><a href="#" target="_blank" > <img   src="'+pic2+'" style = " padding-left:10px; padding-top:2px;"></a></img></div></div>';
							code +=			'<div id="dragContent">Drag and drop files here.<br/><img id="ImageDragUpload" src="'+pic1+'" /></div>'
							code +=		'</div>'
							code +='</div>'
							code +='<div class="timbaBox" id="timbaBox_uploading" style="display: none;">';
							code +=		'<div id="timbaBox_content">';
							code +=			'<div class="content_generated"><div class="headerImg"><a href="#" target="_blank" > <img src="'+pic2+'"style = " padding-left:10px; padding-top:2px;" ></a></img></div></div>';
							code +=			'<div id="progressBar">';
							code +=				'<div id="bar"></div>';
							code +=			'</div><div align="center" id="statusText"></div>';
							code +=				'<div align="center" id="refreshLink"></div>';
							code +=			'</div>';
							code +=		'</div>';
							code +=		'<div class="timbaBox" id="timbaBox_share" style="display: none;">';
							code +=			'<div id="timbaBox_content">';
							code +=				'<div class="content_generated"><div class="headerImg"><a href="#" target="_blank" > <img src="'+pic2+'" style = " padding-left:10px; padding-top:2px;" ></a></img></div></div>';
							code +=				'<div align="center"><textarea id="emailList" cols="27" rows="2" class="emailList"  title="Email your peers so that they can upload faster and easier!">Email your peers so that they can upload faster and easier!</textarea></div>';
							code +=				'<div class="links" id="linkBut" align="center" > <a class="Butt"  id="send" href="javascript:BOXES.sendEmail();">Send</a> <a class="Butt"  id="cancel" href="javascript:BOXES.back();">Cancel</a> <div id="MSent">Sent...</div> <span id="Sent" >Sending...</span> <br> <span id="my_error" ></span> </div>';
							code +=			'</div>';
							code +=		'</div>';
							code +=		'<div class="timbaBox" id="message" style="display:none;">';
							code +=			'<div id="timbaBox_content">';
							code +=				'<div class="content_generated"><div class="headerImg"><a href="#"  target="_blank" > <img src="'+pic2+'" style = " padding-left:10px; padding-top:2px;" ></a></img></div></div>';
							code +=				'<div id="outputText">';
							code +=                 '<div id="Errorbrowser" style="display:none;">This beta works only:<br/> Mozilla Firefox > 3.5 <a href="http://www.mozilla-europe.org/en/firefox/" target="_blank">[Download]</a><br/>Google Chrome > 6 <a href="http://www.google.com/Chrome" target="_blank">[Download]</a></div>';
							code +=					'<div id="googleGears" style="display:none;">You do not have google gears installed.<br/><br/>Go to: <a href="http://gears.google.com" target="_blank">http://gears.google.com</a><br/><br/>Follow the installation steps and try again.</div>';
							code +=					'<div id="fileSize" style="display:none;"><div id="fileName"></div></div>';
							code +=					'<div class="links" align="center">[<a href="javascript:BOXES.back();">back</a>]</div>';
							code +=				'</div>';
							code +=			'</div>';
							code +=		'</div>';
							code += '</div>';
							$("#timbaBox_Container").html(code);					
			},
			
			/*
			 *  shareThisApp
			 *  Show email form
			 */
			shareThisApp : function(){
								$('.timbaBox').hide();
								$('#timbaBox_share').show();
								$(".Butt").show();
			},
		
			/*
			 * back
			 * Back to the home
			 */
			back : function (){
						$("#MSent").css("display", "none");
						$('#send').text("Send");
						$('.timbaBox').hide();
						$('#output').show();
						$('#emailList').val("Email your peers so that they can upload faster and easier!");
						$('#my_error').text("");
			},
			
			/*
		     *  Show error messages
			 *  @param type String the message to show
		     */
			showMessage : function(type){
								this.hideAllDivs();
								this.showDiv("message");
								switch(type){
									case "InternetE":
									this.showDiv("InternetE");
									$('.links').css("display", "none");
									break;
								case "browser":       
									this.showDiv("browser");
									$('.links').css("display", "none");
									break;
								case "Errorbrowser":
									this.showDiv("Errorbrowser");
									$('.links').css("display", "none");
									break;
								default: 
									this.showDiv("fileSize");
								}
			},
			
	        /*
	         * Hide all divs 
	         */
			hideAllDivs : function(){  
								$(".timbaBox").css("display", "none");      
			}, 
			
		    /*
		     *  showDiv
			 *  @param  string Div Id
		     */
			showDiv : function(DivId){
							$("#"+ DivId).css("display", "");
			},
			
			/*
		     *  ShowErrorUp
			 * Generate a string with the error
		     */
			showErrorUp : function(){
							var errors =  model.errors;
							if(errors.error.length>0 || errors.errorArr.length>0 || errors.errorQuery.length>0 || errors.errorMail){
								this.hideAllDivs();
								this.showDiv("message");
								var err='';
								if(errors.error.length>0)
									err='File too big: <br/>'+errors.error+'size limit is 5 MB.<br/><br/>';
								if(errors.errorQuery.length>0 || errors.errorArr.length>0 ){
									err+='An error has ocurred: <br/>';
									if(errors.errorQuery.length>0)
										err+=errors.errorQuery;
									if(errors.errorArr.length>0)
										err+=errors.errorArr;
								}
								err+='Please try again ';
								this.showMessage('fileSize');
								$("#fileName").html(err);
							}
			},
			
			/*
	        *  verifica que hay al menos un mail, en caso contrario 
		 	*  muestra un texto predefinido 
	        */
			sendEmail : function(){
						var errors = model.errors,email = model.email;
						errors.errorMail=false;
						try{
							$(".Butt").hide();
							$("#Sent").show();
							errors.addresError="";
							$("#my_error").text("");
				                        // verifies addres
							if( $("#emailList").val() === "" ){
								$("#emailList").val(email.msgFieldEmpty);
							} else if( ($("#emailList").val() === $("#emailList").attr("title")) || ($("#emailList").val() === email.msgFieldEmpty) ){
								$("#emailList").val(email.msgFieldEmpty);
							} else {
								$(".valueEmails input").val( $("#emailList").val());
								email.addresInput=$("#emailList").val();
								controller.validateAddres();
								controller.sendEmail();
								$("#emailList").val("");
				                                // errors addres
				                                if (errors.addresError.length > 0) {
									$("#emailList").val(errors.addresError);
									$("#my_error").text("Email address is invalid.");
									email.valid=false;
								}
				                                // not errors addres
								if (email.addres.length>0 && errors.addresError.length==0 ){
									//$("#send").text("Sent");
									email.valid=true;
									setTimeout( function(){BOXES.back()}, 3000);
								} else $("#send").text("Send");
						
							}
							$("#Sent").fadeOut(1000, function () {
								if (email.valid){
									$("#Sent").css("display", "none");
									$(".Butt").css("display", "none");
									$("#MSent").css("display", "inline");     
								} else {
									$("#Sent").css("display", "none");
									$(".Butt").show();
								}		                        
							});
							email.addres=new Array();
						}catch(err){
							errors.errorMail=true;
							view.showErrorUp();
						}
			},
			
			/*
			*	Display uploading status
			*/
			uploadingBar : function(filename){
								var currentIndex = model.attachments.currentFileIndex,totalFiles = model.attachments.files.length
								$("#statusText").html("<div>Uploading... "+ parseFloat(currentIndex+1) +"/"+ totalFiles +'</div><div style="margin-top:5px">'+ controller.chopString(filename) +"</div>");
								var barWidth = Math.round((parseFloat($("#progressBar").width()) / totalFiles) * parseFloat(currentIndex+1)) + "px";
								$("#bar").css("width", barWidth);
			}
			,		
			/*
			 *   End of attachment
			 */
			endAttach : function() {
							var errors = model.errors;
							if(errors.error.length > 0 || errors.errorArr.length > 0 || errors.errorQuery.length > 0){
								this.showErrorUp();
							} else {
								$("#bar").css("width", 0);
								$("#statusText").html("<b>Done!</b> <br/>Uploaded attachments to<br/>"  + name +'.<br/> Press F5 to refresh page.');
							}	 
							errors.error='';
							errors.errrArr='';
							errors.errorQuery='';
			}
	};
	
	var controller = {
			   	
			   	connection : null,
			    
			   	/*
				 *  init Events
				 */
				initEvents : function(){
								if(util.browserDetect()){
									this.setEvents();
								}else{
								 	view.showMessage("Errorbrowser");
								}
				},
				
			   	/*
				 * Login
				 * Authentication in salesforce with apex toolkit
			     */
				login : function(sforceConnection,sessionId){
							if(this.connection == null) {
								try{
									this.connection = sforceConnection;
									this.connection.sessionId = sessionId;
								}catch(err){
									model.errors.errorQuery+=err.faultcode+'<br/>';
									view.showErrorUp();
								}
							}
				},
				
				/*
				 * setEventsFirefox
				 * Set events fot firefox
			     */
				setEvents : function(){
								var output = $('#output');
								//$(output).droppable({greedy : true});
								$(output).bind("dragcreate",this.doin);
								$(output).bind("dragover",this.prevent);
								$(output).bind("dragout",this.doout);
								$(output).bind("drop",this.dodrop);
				},
				
				/*
				* checkObject
				* Checks the object ID
				*  @return boolean 
			    */
			   	checkObject : function(){
								var attachments = model.attachments,errors = model.errors;
								errors.errorQuery='';
								try{
									var objectName = this.getObjectName();
									if(objectName == "Case") {
										query = "SELECT obj.Id, obj.CaseNumber FROM " + objectName  
										+ " as obj WHERE obj.Id=\'" +currentObjId + "\'";
										attachments.findResult = this.connection.query(query);
										name=attachments.findResult.records.CaseNumber;
										return attachments.findResult.size > 0;
									} else if (objectName == "Contract"){
										query = "SELECT obj.Id, obj.ContractNumber FROM " + objectName 
										+ " as obj WHERE obj.Id=\'" + currentObjId + "\'";
										attachments.findResult = this.connection.query(query);
										name=attachments.findResult.records.ContractNumber;
										return attachments.findResult.size > 0;
									} else if (objectName != ""){
										query = "SELECT obj.Id, obj.Name FROM " + objectName 
										+ " as obj WHERE obj.Id=\'" + currentObjId + "\'";
										attachments.findResult = this.connection.query(query);
										name=attachments.findResult.records.Name;
										return attachments.findResult.size > 0;
									} else {
										return false;
									}
								}catch(err){
									model.errors.errorQuery='Invalid object ID '+'<br/>';
									view.showErrorUp();
								}
				},
			    
				/*
				* getObjectName
				* Finds out the name of an object by its ID prefix
				*  @return string with the object name
			   	*/
				getObjectName : function (){
									var objectsArray = this.connection.describeGlobal().getArray("sobjects"),
									    objectPrefix;
									// check if it is a valid ID
									objectPrefix = currentObjId.substring(0, 3);
									//  Iterates all objects too find out the object type
									for(var i = 0; i < objectsArray.length; i++){
										if(objectsArray[i].keyPrefix == objectPrefix){
											return objectsArray[i].name;
										}
									}
				},
				
				/*
	   			*  Check if the file the user wants to attach is not above the size limit (5 MB)
		        *  @param file
				*  @return integer
				*/
		        checkFile : function(file){
									var sizeInMegaBytes = (file.size / 1024) / 1024,
									    condition=true;
									condition = (sizeInMegaBytes < 5.0);
									return condition;
				},
				
				/*
		        *  validateAddres
				*  validate email address
		        */
				validateAddres : function(){
									var stringAddres = model.email.addresInput,errors = model.errors,
									email = model.email,
								    commaSeparatedAddres = stringAddres.split(","),   
								    resultAdres = new Array(),
						                    mySplitResult,
						                    verifyAt,
						                    verifyPoint;
						                    
						                // addres separates between ',' ' ' \n
					                $.each(commaSeparatedAddres,function (index,value){
										value = value.replace(/\n/g,' ');
										mySplitResult = value.split(" ");
							                        
										if (mySplitResult.length>1){
											$.each (mySplitResult, function (i,addresValid){
												if(addresValid!='' && addresValid!=' ')
												resultAdres.push(addresValid);
											});
										} else resultAdres.push(mySplitResult);
									});
			                
			                		$.each(resultAdres,function (index,addresValid){
										if(addresValid!=null && addresValid.length > 0 ){
											verifyAt = addresValid.toString().split('@');
											if(verifyAt.length==2)
												verifyPoint = verifyAt[1].toString().split(".");
											if(verifyAt.length == 2 && verifyPoint.length == 2 && verifyPoint[1].length > 1)
												if ((/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/).test(addresValid))           
													email.addres.push(addresValid);
												else 
													errors.addresError=errors.addresError + " " + addresValid ;
											else 
												errors.addresError=errors.addresError + " " + addresValid ;
										}
									});
				},
				
				/*
			     *  sendEmail
				 * Send email to all valid email address 
			     */
				sendEmail : function(){
								// single mail request
								if(model.email.addres.length>0){	
									var singleRequest = new sforce.SingleEmailMessage();
									model.email.addres.push('box@timbasoftware.com');
									singleRequest.replyTo='box@timbasoftware.com';
									singleRequest.senderDisplayName='Timba Boxes';
									singleRequest.subject = FirstName +'  ' + LastName+ " has invited you to use Timba Box";
									singleRequest.htmlBody = FirstName +'  ' + LastName+' from '+CompanyName +' is using Timba Box. '+FirstName+' thought it was a cool toy and thought of sharing it with you. Get your own copy at <a href=\"#">box.timbasoftware.com </a> and start uploading content into Salesforce faster and easier than ever before.<br><br>Enjoy!<br><br>The Timba Box Team.<br><a href=\"#"><img  src="https://emea.salesforce.com/resource/1405045544000/zmulti3a/images/zaimultiupload.png" border=0 ></img></a>';
									singleRequest.toAddresses = model.email.addres;
						
									var sendMailRes = this.connection.sendEmail([singleRequest]);
								}
				},
				
				/*
				 *  Starts the event of droping files into the output div
				 *  @param event
			     */
				dodrop : function(event){
							controller.prevent(event);
							controller.performDrop(event.originalEvent);	
				},
			        
			    /*
				 *  Starts the event of leaving the output div
				 *  @param event
				 */
			    doout :	function(event){
							controller.prevent(event);
				},
				
				/*
				 *  Starts the event of entering to the output div
				 *  @param event
				*/
			    doin : function (event){
					if(window.CanAddFiles)
						controller.prevent(event);
					
				},
				
			    /*
			     *  Performs the actual drop in the box
				 *  @param event
				 */
			    performDrop : function(event){ 
								model.attachments.currentFileIndex = 0;
								model.attachments.files = event.dataTransfer.files;
								$('.timbaBox').hide();
								$('#timbaBox_uploading').show();
								if(util.isAsyncReadfiles){
									controller.uploadAsync();
								}else{
									controller.uploadSync();
								}
				},
				
			    /*
		         *  Prevents default event to occurr
				 *  @param event
	 	        */
				prevent : function(event){
								event.preventDefault();
								event.stopPropagation();
				},
				
				/*
				 *  browserMozilla
				 * Init Mozilla
				 */
				uploadAsync : function(){
									var attachments = model.attachments, errors = model.errors;
									if(attachments.currentFileIndex < attachments.files.length){
										file = attachments.files[attachments.currentFileIndex];
										var valido=controller.checkFile(file);     
										if(valido){
											// create attachment 
							               	controller.getFileBinariesAsync(file);
										} else {
											errors.error+='<a class="aError" title="'+file.name+'" >-  '+this.chopString(file.name)+'</a><br/>';
										}
									} else {
										
										view.endAttach();     
									}
				},
				
				uploadSync : function(){
									var attachments = model.attachments, errors = model.errors,attachment;
									if(attachments.currentFileIndex < attachments.files.length){
										file = attachments.files[attachments.currentFileIndex];
										var valido=this.checkFile(file);     
										if(valido){
											view.uploadingBar(file.name);
							                // create attachment 
							               	attachment = this.createSOAttachment(file.name,currentObjId,this.getFileBinaries(file));
							               	attachments.resultAttachmen = this.upload(attachment,false);
										} else {
											errors.error+='<a class="aError" title="'+file.name+'" >-  '+this.chopString(file.name)+'</a><br/>';
										}  
										this.uploadSync();
									} else {
										
										view.endAttach();     
									}
				},
				
				upload : function(attachment,isAsync,successCallback){
							var attachments = model.attachments,errors =  model.errors;;
							attachments.currentFileIndex=attachments.currentFileIndex+1;
						
		                    //salved attachment
		                    if(isAsync){
		                    	this.connection.create([attachment],
								{	
									onSuccess : function(result){
										successCallback();
									},
									onFailure : function(result){
										controller.errorAttachment(result,attachment.Name);
									}
								})
		                    }else{
		                    	return  this.connection.create([attachment]);
		                    }
		                    
				},
				
				/*
				 * errorAttachment
			     * error to save a attach
				 * @param result string, attachment result
			     */
				errorAttachment : function(result,s){
									for (var i = 0 ; i < result.length; i++){
										if(!result[i].getBoolean("success")){
											if(s=='no')
												model.errors.errorArr+='<a class="aError" title="'+attachments.files[i].name+': '+errors.merror+'" >-  '+this.chopString(attachment.files[i].name+': '+errors.merror)+'</a><br/>';
											else
												model.errors.errorArr+='<a class="aError" title="'+s+': '+errors.merror+'" >-  '+this.chopString(s+': '+errors.merror)+'</a><br/>';
										}
									}
				},
				
				/*
				*	Obtain the binaries from a file
				*/
				getFileBinaries : function(file,isAsync,callback){
									var binary = file.getAsBinary();
									return (new sforce.Base64Binary(binary)).toString();
				},
				
				/*
				*	Obtain the binaries from a file
				*/
				getFileBinariesAsync : function(file,callback){
										var binary;
										var fileReader = new FileReader();
										fileReader.onloadend = function(evt)
													{
														var base64Binary,attachment;
														base64Binary = (new sforce.Base64Binary(evt.target.result)).toString();
														attachment = controller.createSOAttachment(file.name,currentObjId,base64Binary);
														controller.upload(attachment,true,controller.uploadAsync);
													}
										binary = fileReader.readAsBinaryString(file);
									    view.uploadingBar(file.name);
				},
				
				/*
		         *  Trims a string to a specific length and add "..." if string is too long
				 *  @param value string
				 *  @return string
				*/
				chopString : function(value){
									var tempString = value;  
									if(value.length > 15){  
										tempString = tempString.substring(0, 12);
										tempString += "...";
									}
									return tempString;
				},
				
				/*
				*	Create a new SObject with type attachment
				*/
				createSOAttachment : function(name,parentId,body){
										var attachment = new sforce.SObject("Attachment");
										attachment.Body = body;
										attachment.Name = name;
										attachment.ParentId = parentId;
										return attachment; 
				}
					
	};

	var util = {
				
				/*
				*	enable async read files
				*/
				isAsyncReadfiles : null,
				
				/*
			   	* 	Check Firefox with version > 1.9.2
			   	*/
			   	isIESupported : function(){
			   			return ($.browser.msie && this.checkBrowserVersion($.browser.version,'6.0'));
			   	},
			   	
			   	/*
			   	* 	Check Firefox with version >= 1.9.2
			   	*/
			   	isFirefoxSupported : function(){
			   			return ($.browser.mozilla && this.checkBrowserVersion($.browser.version,'1.9.2'));
			   	},
			   	
			   	/*
			   	*	Check chrome with version >= 7.0
			   	*/
			   	isChromeSupported : function(){
			   			var currentVersion,isSupported = navigator.userAgent.toLowerCase().match(/chrome\//) != null;
			   			if(isSupported){
			   				currentVersion = navigator.userAgent.toLowerCase().match(/chrome\/\d*(\.\d)+/gi)[0].split("/")[1]; 
			   				isSupported = this.checkBrowserVersion(currentVersion,'7.0');
			   			}
			   			return isSupported;
				   		
			   	},
				
				/*
			   	*	Check safari with version >= 6.0
			   	*  someday... the file API is in nightly builds of Safari 6
			   	*/
			   	
			   	isSafariSupported : function(){
			   			var currentVersion,isSupported = navigator.userAgent.toLowerCase().match(/safari\//) != null;
			   			if(isSupported){
			   				currentVersion = navigator.userAgent.toLowerCase().match(/version\/\d+(\.\d+)+/gi)[0].split("/")[1]; 
			   				isSupported = this.checkBrowserVersion(currentVersion,'6.0');
			   			}
			   			return isSupported;
				
			   	},
			   	
			   	/*
			   	*	Check browser is supported
			   	*/
			    browserDetect : function(){
    					var isBrowserSupported = this.isFirefoxSupported() || this.isChromeSupported() || this.isSafariSupported();
    					 
						// check if exists the native method in the File object.
    					this.isAsyncReadfiles = !(typeof(File) != "undefined" && File.prototype.hasOwnProperty("getAsBinary"));
    				
    					// check if exists the native object named FileReader
    					if(this.isAsyncReadfiles){
    						this.isAsyncReadfiles = typeof(FileReader) != "undefined";
    					} 
    					
    					return isBrowserSupported;
				},
				
				/*
				*	check the browser version with the following format "X.X", comparing these values
				*	are currentVersion >= smallerVersion
				*/
				checkBrowserVersion : function(currentVersion,smallerVersion){
				        var isGreater = false, isSmaller = true,numberCurrent,numberSmaller;
                        tokenCurrent = currentVersion.split(".");
                        tokenSmaller = smallerVersion.split(".");
                        for(var i=0; i<tokenSmaller.length;i++){
                            numberCurrent = parseInt(tokenCurrent[i]);
                            numberSmaller = parseInt(tokenSmaller[i]);
                            isGreater = numberCurrent > numberSmaller;
                            isSmaller = numberCurrent < numberSmaller;
                            if(isGreater || isSmaller){
                                break;
                            } 
                        }
                        return (isGreater || !isSmaller);
				}
	
	};
	
	var init = function(){
					controller.login(sforce && sforce.connection,sessionId);
					view.createHTML();
					if(!controller.checkObject()){
						$("#output").css("display", "none");
					}
					$("#emailList").focus(function () {
						if( ($(this).val() === $(this).attr("title")) || ($(this).val() === email.msgFieldEmpty) ){
							$(this).val("");
						}
					});
					$('body').css('background-image', 'none');
					controller.initEvents();
	}
				
	//Public Methods
	return {
		init : init,
		back : view.back,
		sendEmail : view.sendEmail,
		shareThisApp : view.shareThisApp
	}
};



/*
 * On dom ready function -Init 
    */
window.onload = function() {
	BOXES = new TimbaBoxes(jQuery);
	BOXES.init();
};