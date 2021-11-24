import { Controller } from "@hotwired/stimulus"
import {$,jQuery} from 'jquery'
// export for others scripts to use
import 'jszip'
import 'pdfmake'
import 'datatables.net'
import 'datatables.net-bs5'
import 'datatables.net-buttons'
import 'datatables.net-buttons-bs5'
import 'datatables.net-buttons/js/buttons.colVis.js'
import 'datatables.net-buttons/js/buttons.html5.js'
import 'datatables.net-buttons/js/buttons.print.js'

// import { DataTable } from "datatables.net"

export default class extends Controller {
  static targets = [ "datatable", "remotetable", "plaintable" ]

  connect() {
    console.log("datatable controller connected")
    // let table = new DataTable(this.datatableTarget)
    $(this.datatableTarget).DataTable()
//    if (this.hasDatatableTarget) {
//      this.datatableTargets.forEach(table => {
//	  $(table).DataTable({
//	    "pagingType": "full_numbers",
//	    "dom": "<'row'<'col'l><'col'BC><'col'f>>t<'row'<'col'ir><'col'p>>",
//	    "stateSave": false,
//	    "lengthMenu": [ [10, 25, 100, 250, 1000], [10, 25, 100, 250, 1000] ],
//	    "buttons": [
//	      { 
//		"extend": 'copy',
//		"className": 'btn-outline-secondary btn-sm',
//		"exportOptions": {
//		  "columns": ':visible',
//		  "search": ':applied'
//		}
//	      },
//	      { 
//		"extend": 'excelHtml5',
//		 // "title": $('table[role="datatable"]').data('title'),
//		"className": 'btn-outline-secondary btn-sm',
//		"exportOptions": {
//		  "search": ':applied'
//		}
//	      },
//	      { 
//		"extend": 'pdf',
//		"className": 'btn-outline-secondary btn-sm',
//		"orientation": 'landscape',
//		"pageSize": 'A4',
//		"exportOptions": {
//		  "columns": ':visible',
//		  "search": ':applied'
//		}
//	      },
//	      { 
//		"extend": 'print',
//		"className": 'btn-outline-secondary btn-sm',
//	      },
//	      { 
//		"extend": 'colvis',
//		"className": 'btn-outline-secondary btn-sm',
//		// "text": "<%= I18n.t('titracka.change_columns') %>",
//		"columns": ':gt(0)'
//	      }
//	    ],
//	    "columnDefs": [
//	      { "targets": "nosort", "orderable": false },
//	      { "targets": "notvisible", "visible": false }
//	    ]
//	  }) // .DataTable()
//        } // table
//      ) // forEach
//    } // hasDatatableTarget
  } // connect
} // Controller
