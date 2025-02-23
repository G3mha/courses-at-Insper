# Load Quartus Prime Tcl Package
#package require  ::quartus::insystem_source_probe

variable usb
variable debug

proc inicializaHardware {} {
  global usb device_name debug
  if { [catch {set usb [lindex [get_hardware_names] 0]} id_erro]} {
    puts "Erro ao ler o probe: $id_erro"
    exit
  }

  if { [catch {set device_name [lindex [get_device_names -hardware_name $usb] 0]} id_erro] } {
    puts "Erro ao obter o nome do device: $id_erro"
    exit
  }
}

# Leitura do probe número 0:
proc ler_probe {} {
  global device_name usb Leitura
  variable Leitura
  if { [catch {start_insystem_source_probe -device_name $device_name -hardware_name $usb} id_erro] } {
    puts "Erro ao iniciar o probe: $id_erro"
    exit
  }
  if { [catch {set Leitura [read_probe_data -instance_index 0]} id_erro]} {
    puts "Erro ao ler o probe: $id_erro"
    exit
  }
  end_insystem_source_probe
  #puts "Valor do PROBE, lido em binário: $Leitura"
  return $Leitura
}

inicializaHardware
set valorBinario [ler_probe]
# Remove todos os espaços da string
set valorBinario [string map {" " ""} $valorBinario]
set valorBinario [format %0512s $valorBinario]
set binario [string range $valorBinario 0 511]
#puts "$usb"
#puts "$device_name"
puts "$binario"