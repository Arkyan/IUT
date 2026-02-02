const Formulaire = () => {
  return (
    <form>
        <div className="mb-3">
            <label htmlFor="name" className="form-label">Nom :</label>
            <input type="text" className="form-control" id="name" />
        </div>
        <div className="mb-3">
            <label htmlFor="firstname" className="form-label">Prénom :</label>
            <input type="text" className="form-control" id="firstname" />
        </div>
        <div className="mb-3">
            <label htmlFor="email" className="form-label">Email :</label>
            <input type="email" className="form-control" id="email" />
        </div>
        <button type="submit" className="btn btn-primary">Valider</button>
    </form>
    )
};

export default Formulaire;