import { Controller } from "@hotwired/stimulus"
import $ from 'jquery'
window.jQuery = window.$ = $
import JSZip from 'jszip'
window.JSZip = JSZip
import 'pdfmake'
import dataTable from 'datatables.net-bs5'
dataTable(window, $)
import buttons from 'datatables.net-buttons-bs5'
buttons(window, $)
import columnVisibility from 'datatables.net-buttons/js/buttons.colVis.js'
columnVisibility(window, $)
import buttonsHtml5 from 'datatables.net-buttons/js/buttons.html5.js'
buttonsHtml5(window, $)
import buttonsPrint from 'datatables.net-buttons/js/buttons.print.js'
buttonsPrint(window, $)
// import responsive from 'datatables.net-responsive-bs5/js/responsive.bootstrap5.js'
// import 'datatables.net-responsive'
// responsive(window, $)
// import colReorder from 'datatables.net-colreorder-bs4'
// colReorder(window, $)
// import fixedColumns from 'datatables.net-fixedcolumns-bs4'
// fixedColumns(window, $)
// import scroller from 'datatables.net-scroller-bs4'
// scroller(window, $)

export default class extends Controller {
  static targets = [ "datatable", "remotetable", "plaintable" ]

  initialize() {
    // console.log("datatable controller initialized")
    var myTable = $.fn.dataTable;
    $.extend( true, myTable.Buttons.defaults, {
      "dom": {
        "button": {
          "className": 'btn btn-outline-secondary btn-sm'
        }
      }
    });
  }

  connect() {
    console.log("datatable controller connected")
    $(this.datatableTarget).DataTable({
      "style": "bootstrap",
      "pagingType": "full_numbers",
      "dom": "<'row'<'col'l><'col'B><'col'f>>" +
             "<'row'<'col-sm-12'tr>>" +
             "<'row'<'col'i><'col'p>>",
      "stateSave": false,
      "lengthMenu": [ [10, 25, 100, 250, 1000], [10, 25, 100, 250, 1000] ],
      "buttons": [
        { 
          "extend": 'copy',
          "className": 'btn-outline-secondary btn-sm',
          "exportOptions": {
            "columns": ':visible',
            "search": ':applied'
          }
        },
        { 
          "extend": 'excelHtml5',
           // "title": $('table[role="datatable"]').data('title'),
          "className": 'btn-outline-secondary btn-sm',
          "exportOptions": {
            "search": ':applied'
          }
        },
        { 
          "extend": 'pdf',
          "className": 'btn-outline-secondary btn-sm',
          "orientation": 'landscape',
          "pageSize": 'A4',
          "exportOptions": {
            "columns": ':visible',
            "search": ':applied'
          }
        },
        { 
          "extend": 'print',
          "className": 'btn-outline-secondary btn-sm',
        },
        { 
          "extend": 'colvis',
          "className": 'btn-outline-secondary btn-sm',
          // "text": "<%= I18n.t('titracka.change_columns') %>",
          "columns": ':gt(0)'
        }
      ],
      "columnDefs": [
        { "targets": "nosort", "orderable": false },
        { "targets": "notvisible", "visible": false }
      ]
    }) // .DataTable()
  } // connect
} // Controller
