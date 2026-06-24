import React,{useState,useEffect,use} from "react";
import './App.css';
import 'bootstrap/dist/css/bootstrap.min.css';
import axios from 'axios';
import { Button, Modal,ModalBody,ModalFooter,ModalHeader } from "reactstrap";

const baseUrl ='${import.meta.env.VITE_API_URL}/gestores'

function App(){
  const baseUrl="https://localhost:7285/api/gestores";
  //para controlar cuando se abren y cierran modales
  const [data,setData]=useState([]);
  const [modalInsertar,setModalInsertar]=useState(false);
  const [modalEditar,setModalEditar]=useState(false);
  const [modalEliminar,setModalEliminar]=useState(false);

  //metodo que utiliza hooks por que usa el useState
  //funcion para modificar los estados
  const [gestorSeleccionado,setGestoresSeleccionado]=useState({
     idGestores:"",
     nombre:'',
     lazamiento:'',
     desarrollador:''

  })

  //Metodo para captura los inputs
  const handleChange = e =>{
    const {name,value}=e.target;
    setGestoresSeleccionado({
      ...gestorSeleccionado,
      [name]:value
    });
    console.log(gestorSeleccionado);
  };

  const abrirCerrarModalInsertar=()=>{
    setModalInsertar(!modalInsertar);
  }

  const abrirCerrarModalEditar=()=>{
    setModalEditar(!modalEditar);
  }

  const abrirCerrarModalEliminar=()=>{
    setModalEliminar(!modalEliminar);
  }

  const peticionesGet=async()=>{
    await axios.get(baseUrl)
    .then(response=>{
      setData(response.data);
    }).catch(error=>{
      console.log(error);
    })
  }

  //Nuevo metodo
  const peticionPost = async () => {
    try{
      //Crear un nuevo objeto con los campos que espera la Api
      const nuevoGestor = {
        nombre:gestorSeleccionado.nombre,
        desarrollador:gestorSeleccionado.desarrollador,
        lazamiento:gestorSeleccionado.lazamiento
        ? parseInt(gestorSeleccionado.lazamiento)
        :0 //o puede usar null si el campo lo permite
      };
      console.log("📦 Enviando a la API:",nuevoGestor);
      const response = await axios.post(baseUrl,nuevoGestor,{
        headers:{"Content-Type":"application/json"}
      });

      setData([...data,response.data]);
      abrirCerrarModalInsertar();
    }catch (error){
      console.error("❌ Error al insertar:", error);
      if(error.response){
        console.error("😫Respuesta del servidor:",error.response.data);
      }
    }
  };

  //metodo put
  const peticionPut=async()=>{
    gestorSeleccionado.lazamiento=parseInt(gestorSeleccionado.lazamiento);
    await axios.put(baseUrl+"/"+gestorSeleccionado.idGestores,gestorSeleccionado)
    .then(response=>{
      var respuesta=response.data;
      var dataAuxiliar=data;
      dataAuxiliar.map(gestor=>{
        if(gestor.idGestores===gestorSeleccionado.idGestores){
          gestor.nombre=respuesta.nombre;
          gestor.lazamiento=respuesta.lazamiento;
          gestor.desarrollador=respuesta.desarrollador;
        }
      })
      abrirCerrarModalEditar();
    }).catch(error=>{
      console.log(error);
    })
  }//fin de metodo put

  //Inicia Delete
  const peticionesDelete=async()=>{
    await axios.delete(baseUrl+"/"+gestorSeleccionado.idGestores)
    .then(response=>{
      setData(data.filter(gestor=>gestor.idGestores!==response.data));
      abrirCerrarModalEliminar();
    }).catch(error=>{
      console.log(error);
    })
  }//Fin del metodo delete

  //Metodo que asigne al estado cual es el gestor a editar o elimnar
  const seleccionarGestor=(gestor,caso)=>{
    setGestoresSeleccionado(gestor);
    (caso === "Editar")?
    abrirCerrarModalEditar(): abrirCerrarModalEliminar();
  }//Fin metodo


  useEffect(()=>{
    peticionesGet();
  },[])

  return(
    <div className="App">
      <br/><br/>
      <button onClick={()=>abrirCerrarModalInsertar()} className="btn btn-success">Insertar nuevo gestor</button>
      <br/><br/>
      <table className="table table-bodered">
        <thead>
          <tr>
            <th>Id</th>
            <th>Nombre</th>
            <th>Lanzamiento</th>
            <th>Desarrollador</th>
            <th>Acciones</th>
          </tr>
        </thead>
        <tbody>
          {data.map(gestor=>(
            <tr key={gestor.idGestores}>
              <td>{gestor.idGestores}</td>
              <td>{gestor.nombre}</td>
              <td>{gestor.lazamiento}</td>
              <td>{gestor.desarrollador}</td>
              <td>
                <button className="btn btn-primary" onClick={()=>seleccionarGestor(gestor,"Editar")}>Editar</button>{" "}
                <button className="btn btn-danger" onClick={()=>seleccionarGestor(gestor,"Eliminar")}>Eliminar</button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>

      <Modal isOpen={modalInsertar}>
        <ModalHeader>Insertaer Gestor de base de datos</ModalHeader>
        <ModalBody>
          <div className="form-group">
            <label>Id:</label>
            <br />
            <input type="text" className="form-control" name="idGestores" onChange={handleChange}/>
            <br/>
            <label>Nombre:</label>
            <br />
            <input type="text" className="form-control" name="nombre" onChange={handleChange}/>
            <br/>
            <label>Lanzamiento:</label>
            <br />
             <input type="text" className="form-control" name="lazamiento" onChange={handleChange}/>
            <br/>
            <label>Desarrollador:</label>
            <br />
             <input type="text" className="form-control" name="desarrollador" onChange={handleChange}/>
            <br/>        
          </div>
        </ModalBody>
        <ModalFooter>
          <button className="btn btn-primary" onClick={()=>peticionPost()}>Insertar</button>{" "}
          <button className="btn btn-danger" onClick={()=>abrirCerrarModalInsertar()}>Cancelar</button>
        </ModalFooter>
      </Modal>
      
      <Modal isOpen={modalEditar}>
        <ModalHeader>Edita Gestor de Base de datos</ModalHeader>
        <ModalBody>
          <div className="form-group">
            <label>ID:</label>
            <br/>
            <input type="text" className="form-control" name="idGestores" onChange={handleChange} value={gestorSeleccionado && gestorSeleccionado.idGestores}/>
            <br/>
            <label>Nombre:</label>
            <br/>
            <input type="text" className="form-control" name="nombre" onChange={handleChange} value={gestorSeleccionado && gestorSeleccionado.nombre}/>
             <br/>
            <label>Lanzamiento:</label>
            <br/>
            <input type="text" className="form-control" name="lazamiento" onChange={handleChange} value={gestorSeleccionado && gestorSeleccionado.lazamiento}/>
            <br/>
            <label>Desarrollador:</label>
            <br/>
            <input type="text" className="form-control" name="desarrollador" onChange={handleChange} value={gestorSeleccionado && gestorSeleccionado.desarrollador}/>
            <br/>
          </div>                   
        </ModalBody>
        <ModalFooter>
          <button className="btn btn-primary" onClick={peticionPut}>Editar</button>{" "}
          <button className="btn btn-danger" onClick={()=>abrirCerrarModalEditar()}>Cancelar</button>
        </ModalFooter>
      </Modal>


      <Modal isOpen={modalEliminar}>
        <ModalBody>
          Estas seguro de eliminar el gestor {gestorSeleccionado && gestorSeleccionado.nombre} ?
        </ModalBody>

        <ModalFooter>
          <button className="btn btn-danger"  onClick={() => peticionesDelete()}>
            si
          </button>

          <button className="btn btn-secondary" onClick={()=>abrirCerrarModalEliminar()}>
            No
          </button>
        </ModalFooter>
      </Modal>
    </div>
  );
}

export default App;
   
  