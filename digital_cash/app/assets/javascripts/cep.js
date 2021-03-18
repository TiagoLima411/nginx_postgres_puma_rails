var last_cep = 0;
var address;
var lat;
var lng;
var wsconf;
function wscep(conf)
{
    //parametros padrao true
    if(!conf){
        conf = {
            'auto': true,
            'map' : '',
            'wsmap' : ''
        };
    }
    wsconf = conf;
    //evento keyup no campo cep opcional
    if(wsconf.auto == true){
    	jQuery("#consultarCEP").click(function(){
    		 var cep = jQuery.trim(jQuery('.cep').val()).replace('_','').replace('_','').replace('_','').replace('_','').replace('_','').replace('_','').replace('_','').replace('_','');
             if(cep.length >= 9){
                 if(cep != last_cep){
                     busca();
                 }
             }
    	});
    	jQuery('.cep, #cep').keyup(function(){
            var cep = jQuery.trim(jQuery(this).val()).replace('_','').replace('_','').replace('_','').replace('_','').replace('_','').replace('_','').replace('_','').replace('_','');
            if(cep.length >= 9){
                if(cep != last_cep){
                    busca(cep);
                }
            }
        });         
    }
}
    
//busca o cep
function busca(cep){
   
    
    jQuery.getJSON("//viacep.com.br/ws/"+ cep +"/json/?callback=?", function(dados) {

        if (!("erro" in dados)) {
            //Atualiza os campos com os valores da consulta.
            jQuery("#endereco , #logradouro").val(dados.logradouro);
            jQuery("#bairro").val(dados.bairro);
            jQuery("#cidade").val(dados.localidade);
            jQuery("#uf").val(dados.uf);
         
        } //end if.
        else {
            
            alert("CEP não encontrado.");
            jQuery("#loader").hide();
        }
    });
   
   
   
}
 
function wsmap(cep,num,elm)
{
	  var url = 'https://viacep.com.br/ws/'+cep+'/json/';  
    if (jQuery.browser.msie) {
        var url = 'ie.php';    
    }    
    jQuery.post(url,{
        cep:cep
    },
    function (rs) {
        if(rs != 0){
        rs = jQuery.parseJSON(rs);
            address = rs.endereco + ', ' + num + ', ' + rs.bairro + ', ' + rs.cidade + ', ' + ', ' + rs.uf;
            setMap(elm);
        }
    })
}
function setMap(elm)
{
    GMaps.geocode({
        address: address,
        callback: function(results, status) {            
            if (status == 'OK') {
                //console.log(elm);
                jQuery('#'+elm).show();
                var latlng = results[0].geometry.location;
                lat = latlng.lat();
                lng = latlng.lng()
                map = new GMaps({
                    div: elm,
                    lat: lat,
                    lng: lng,
                    scrollwheel: false,
                    mapTypeId: google.maps.MapTypeId.ROADMAP,
                    streetViewControl: true,
                    zoom: 14
                })
                map.addMarker({
                    lat: lat,
                    lng: lng,
                    title: address,
                    infoWindow: {
                        content: '<p>'+address+'</p>'
                    }
                });
                map.setCenter(lat, lng);
            }
        }
    });   
     
}
