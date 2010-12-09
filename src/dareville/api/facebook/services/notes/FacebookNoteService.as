package dareville.api.facebook.services.notes
{
	import dareville.api.facebook.FacebookConstants;
	import dareville.api.facebook.data.notes.FacebookNoteCollectionData;
	import dareville.api.facebook.data.notes.FacebookNoteCreateData;
	import dareville.api.facebook.services.common.AbstractFacebookService;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import mx.messaging.AbstractConsumer;
	
	import org.osflash.signals.Signal;
	
	/**
	 * The <code>FacebookNoteService</code> class access to notes data.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author kris@dareville.com
	 */
	public class FacebookNoteService 
		extends AbstractFacebookService
	{
		//----------------------------------
		//  Signals
		//----------------------------------
		
		/**
		 * Signal dispatched when the load notes has completed. Dispatches a
		 * <code>FacebookNoteCollectionData</code> as a parameter. 
		 */		
		public var notesLoaded : Signal = new Signal( FacebookNoteCollectionData );
		
		/**
		 * Signal dispatched when a note is created. Dispatches a
		 * <code>String</code> as a parameter.
		 */		
		public var noteCreated : Signal = new Signal( String );
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Retrieves data for all notes associated with a user/page.
		 * 
		 * <p>If the request succeeds, a <code>notesLoaded</code> Signal is 
		 * dispatched containing an <code>FacebookNoteCollectionData</code> 
		 * instance.</p>
		 * 
		 * @param access_token Facebook access token
		 * @param page_id Page ID to request
		 * 
		 * @return URLLoader Loader
		 * 
		 * @example This example retrieves the currently logged in users notes:
<listing version="3.0">
var service : FacebookNoteService = new FacebookNoteService();
service.notesLoaded.addOnce( onNotesLoaded );
service.getNotes( access_token );
 
function onNotesLoaded( vo : FacebookNoteCollectionData ):void
{
	service.notesLoaded.removeAll();
}</listing>
		 */			
		public function getNotes( 
			access_token : String, 
			page_id : String = FacebookConstants.CONNECTION_ME ) : URLLoader
		{
			var loader : URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.addEventListener( IOErrorEvent.IO_ERROR, onNotesLoadIOError, false, 0, true );
			loader.addEventListener( Event.COMPLETE, onNotesLoadComplete, false, 0, true );
			
			// Call the service
			call( loader, page_id + "/" + FacebookConstants.CONNECTION_NOTES, access_token  );
			return loader;
		}
		
		/**
		 * Posts a note to the specified page ID. 
		 * 
		 * <p>If the request succeeds, a <code>notesCreated</code> Signal is 
		 * dispatched containing a <code>String</code> of the note ID.</p>
		 * 
		 * @param access_token Facebook access token
		 * @param page_id Page ID to request
		 * @param note Value object containing all the information needed to create the note
		 * 
		 * @return URLLoader Loader
		 * 
		 * @example This example creates a note for the currently logged 
		 * in user:
<listing version="3.0">
var note : FacebookNoteCreateData = new FacebookNoteCreateData( "this is the subject", "this is the note" );
var service : FacebookNoteService = new FacebookNoteService();
service.noteCreated.addOnce( onNotesCreate );
service.createNote( access_token, FacebookConstants.CONNECTION_ME, note );
 
function onNotesCreate( id : String ):void
{
	service.noteCreated.removeAll();
}</listing>
		 */		
		public function createNote( 
			access_token : String, 
			page_id : String,
			note : FacebookNoteCreateData ) : URLLoader
		{
			if( access_token )
			{
				var loader : URLLoader = new URLLoader();
				loader.dataFormat = URLLoaderDataFormat.TEXT;
				loader.addEventListener( IOErrorEvent.IO_ERROR, onNotesCreateIOError );
				loader.addEventListener( Event.COMPLETE, onNotesCreateComplete );
				
				var data : URLVariables = new URLVariables();
				data.message = note.message;
				data.subject = note.subject;
				
				// Call the service
				call( loader, page_id + "/" + FacebookConstants.CONNECTION_NOTES, access_token, data, URLRequestMethod.POST );
				return loader;
			}
			return null;
		}
		
		//---------------------------------------------------------------------
		//
		//  Private methods
		//
		//---------------------------------------------------------------------
		
		//----------------------------------
		//  Handlers
		//----------------------------------
		
		/**
		* @private
		* Callback for when the notes load completes
		* 
		* @param event <code>Event.COMPLETE</code> 
		*/	
		private function onNotesLoadComplete( event : Event ) : void
		{
			// Remove event listeners
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onNotesLoadIOError );
			loader.removeEventListener( Event.COMPLETE, onNotesLoadComplete );
			
			// Decode the JSON data
			var json_data : Object = decodeData( loader.data );
			
			var vo : FacebookNoteCollectionData = new FacebookNoteCollectionData( json_data );
			notesLoaded.dispatch( vo );
			
			// NULL the loader
			loader = null;
		}
		
		/**
		 * @private
		 * Callback for when the notes load IO errors
		 * 
		 * @param event <code>Event.COMPLETE</code> 
		 */	
		private function onNotesLoadIOError( event : Event ) : void
		{
			// Remove event listeners
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onNotesLoadIOError );
			loader.removeEventListener( Event.COMPLETE, onNotesLoadComplete );
			
			errored.dispatch( loader.data );
			
			// NULL the loader
			loader = null;
		}
		
		/**
		 * @private
		 * Callback for when the notes create completes
		 * 
		 * @param event <code>Event.COMPLETE</code> 
		 */	
		private function onNotesCreateComplete( event : Event ) : void
		{
			// Remove event listeners
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onNotesCreateIOError );
			loader.removeEventListener( Event.COMPLETE, onNotesCreateComplete );
			
			// Decode the JSON data
			var json_data : Object = decodeData( loader.data );
			
			// Dispatch the note ID
			noteCreated.dispatch( json_data.id );
			
			// NULL the loader
			loader = null;
		}
		
		/**
		 * @private
		 * Callback for when the notes create IO errors
		 * 
		 * @param event <code>Event.COMPLETE</code> 
		 */	
		private function onNotesCreateIOError( event : Event ) : void
		{
			// Remove event listeners
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( IOErrorEvent.IO_ERROR, onNotesCreateIOError );
			loader.removeEventListener( Event.COMPLETE, onNotesCreateComplete );
			
			errored.dispatch( loader.data );
			
			// NULL the loader
			loader = null;
		}
	}
}