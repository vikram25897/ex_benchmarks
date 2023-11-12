use rayon::prelude::*;
#[rustler::nif(schedule = "DirtyCpu")]
fn parallel_sort(v: Vec<i32>) -> Vec<i32>{
    let vec = &mut v.to_vec();
    vec.par_sort_unstable();
    return vec.to_vec();
}

#[rustler::nif(schedule = "DirtyCpu")]
fn glide_sort(v: Vec<i32>) -> Vec<i32>{
    let vec = &mut v.to_vec();
    glidesort::sort(vec);
    return vec.to_vec();
}

#[rustler::nif(schedule = "DirtyCpu")]
fn normal_sort(v: Vec<i32>) -> Vec<i32>{
    let mut vec = v.to_vec();
    vec.sort_unstable();
    return vec;
}

rustler::init!("Elixir.ExBenchmarks.RustSort", [parallel_sort, glide_sort, normal_sort]);
